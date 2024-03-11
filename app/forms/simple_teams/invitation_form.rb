module SimpleTeams
  class InvitationForm < ApplicationForm

    attr_accessor :team, :current_user, :invitation, :email_address, :role

    def initialize(team, current_user)
      raise NotImplementedError
    end

    def perform(params)
      self.assign_attributes(params)

      if valid?
        invitation.update(params)
        generate_notification
      else
        false
      end
    end

    # Attributes
    def self.invitation_attributes
      [:email_address, :role]
    end

    def available_roles
      @available_roles ||= SimpleTeams::Membership.roles
    end

    private

    def valid?
      self.errors.clear
      validate_role_is_available
      validate_invitation
      validate_current_user_has_rights_to_invite_an_owner
      !self.errors.present?
    end

    def validate_role_is_available
      # Note: Users will never see this error message unless they hack the form
      if role.present?
        unless available_roles.keys.include? role
          self.errors.add(:role, "that role is not available for this resource")
        end
      end
    end

    def validate_invitation
      # Update invitation object
      self.class.invitation_attributes.each do |a|
        invitation.assign_attributes(a => self.send(a))
      end

      # Call valid?
      invitation.valid?

      # Reassign errors
      self.class.invitation_attributes.each do |a|
        if invitation.errors[a].present?
          invitation.errors[a].each do |e|
            self.errors.add(a, e)
          end
        end
      end
    end

    def validate_current_user_has_rights_to_invite_an_owner
      if role == "owner"
        unless current_user.membership_for_team(team).owner?
          self.errors.add(:role, "you must be an owner yourself to add add another owner")
        end
      end
    end

  end
end
