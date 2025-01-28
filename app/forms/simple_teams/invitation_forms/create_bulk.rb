module SimpleTeams
  class InvitationForms::CreateBulk < ApplicationForm

    attr_accessor :team, :current_user, :single_vs_multiple, :select2_emails, :accessible_emails, :emails, :role

    def initialize(team, current_user)
      @team = team
      @current_user = current_user
      @emails = []
    end

    def perform(params)
      self.assign_attributes(params)
      if accessible?
        self.emails = accessible_emails.split(",").map(&:strip).uniq.reject(&:empty?)
      else
        self.emails = select2_emails.map(&:strip).uniq.reject(&:empty?)
      end

      if valid?
        create_invitations
        generate_notification
      else
        false
      end
    end

    # Attributes
    def available_roles
      SimpleTeams::Membership.roles
    end

    private

    def accessible?
      single_vs_multiple == "accessible"
    end

    def address_attribute
      accessible? ? :accessible_emails : :select2_emails
    end

    def valid?
      self.errors.clear
      validate_attributes_present
      validate_invitations
      validate_role_is_available
      validate_current_user_has_rights_to_invite_an_owner
      !self.errors.present?
    end

    def validate_attributes_present
      [:team, :current_user, :role].each do |a|
        unless self.send(a).present?
          self.errors.add(a, "can't be blank")
        end
      end
      unless self.emails.present?
        self.errors.add(address_attribute, "can't be blank")
      end
    end

    def validate_invitations
      emails.each do |email|
        invitation = SimpleTeams::Invitation.new(
          :team => team,
          :inviter => current_user,
          :role => role,
          :email => email
        )
        unless invitation.valid?
          invitation.errors[:email].each do |error|
            if error == "is invalid"
              error_message = "#{email} is not a valid email address"
            else
              error_message = error.gsub("this email address", email)
            end
            self.errors.add(address_attribute, error_message)
          end
        end
      end
    end

    def validate_role_is_available
      # Note: Users will never see this error message unless they hack the form
      if role.present?
        unless available_roles.keys.include? role
          self.errors.add(:role, "that role is not available for this resource")
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

    def create_invitations
      ActiveRecord::Base.transaction do
        emails.each do |email|
          SimpleTeams::Invitation.create!(
            :team => team,
            :inviter => current_user,
            :role => role,
            :email => email
          )
        end
      end
    end

    def generate_notification
      SimpleTeams::BulkInvitationsNotifier.with(
        :team_id => team.id,
        :user_id => current_user.id,
        :team_name => team.name,
        :user_name => current_user.full_name,
        :invitation_names => self.emails,
      ).deliver_later(team.members)
    end

  end
end
