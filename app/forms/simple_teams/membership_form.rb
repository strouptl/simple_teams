module SimpleTeams
  class MembershipForm < ApplicationForm

    attr_accessor :membership, :current_user, :role

    def initialize(membership, current_user)
      @membership = membership
      @current_user = current_user

      # Get existing attributes
      @role = @membership.role
    end

    def valid?
      self.errors.clear
      validate_role_is_available
      validate_current_user_has_rights_to_modify_an_existing_owner
      validate_current_user_has_rights_to_add_an_owner
      validate_not_last_owner
      !self.errors.present?
    end

    def perform(params)
      self.assign_attributes(params)

      if valid?
        membership.update(params)
        generate_notification
      else
        false
      end
    end

    def available_roles
      @available_roles ||=
        if team.child_team?
          SimpleTeams::Membership.roles.except("owner")
        else
          SimpleTeams::Membership.roles
        end
    end

    private

    def validate_role_is_available
      # Note: Users will never see this error message unless they hack the form
      if role.present?
        unless available_roles.keys.include? role
          self.errors.add(:role, "that role is not available for this resource")
        end
      end
    end

    def validate_not_last_owner
      if membership.owner? and only_one_owner? and role != "owner"
        unless team.child_team?
          self.errors.add(:role, "you can't remove the last owner of a team")
        end
      end
    end

    def validate_current_user_has_rights_to_modify_an_existing_owner
      if membership.owner?
        unless current_user.membership_for_team(team).owner?
          self.errors.add(:role, "you must be an owner yourself to modify another owner")
        end
      end
    end

    def validate_current_user_has_rights_to_add_an_owner
      if role == "owner" and !membership.owner?
        unless current_user.membership_for_team(team).owner?
          self.errors.add(:role, "you must be an owner yourself to add add another owner")
        end
      end
    end

    def only_one_owner?
      team.memberships.where(:role => :owner).count == 1
    end

    def team
      membership.team
    end

    def generate_notification
      SimpleTeams::Memberships::UpdatedNotification.with(
        :team_id => team.id,
        :member_id => membership.member.id,
        :user_id => current_user.id,
        :team_name => team.name,
        :member_name => membership.member.full_name,
        :user_name => current_user.full_name
      ).deliver_later(team.members)
    end

  end
end
