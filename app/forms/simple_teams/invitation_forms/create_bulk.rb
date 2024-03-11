module SimpleTeams
  class InvitationForms::CreateBulk < ApplicationForm

    attr_accessor :team, :current_user, :single_vs_multiple, :select2_email_addresses, :accessible_email_addresses, :email_addresses, :role

    def initialize(team, current_user)
      @team = team
      @current_user = current_user
      @email_addresses = []
    end

    def perform(params)
      self.assign_attributes(params)
      if accessible?
        self.email_addresses = accessible_email_addresses.split(",").map(&:strip).uniq.reject(&:empty?)
      else
        self.email_addresses = select2_email_addresses.map(&:strip).uniq.reject(&:empty?)
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
      @available_roles ||=
        if team.child_team?
          SimpleTeams::Membership.roles.except("owner")
        else
          SimpleTeams::Membership.roles
        end
    end

    private

    def accessible?
      single_vs_multiple == "accessible"
    end

    def address_attribute
      accessible? ? :accessible_email_addresses : :select2_email_addresses
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
      unless self.email_addresses.present?
        self.errors.add(address_attribute, "can't be blank")
      end
    end

    def validate_invitations
      email_addresses.each do |email_address|
        invitation = Teams::Invitation.new(
          :team => team,
          :inviter => current_user,
          :role => role,
          :email_address => email_address
        )
        unless invitation.valid?
          invitation.errors[:email_address].each do |error|
            if error == "is invalid"
              error_message = "#{email_address} is not a valid email address"
            else
              error_message = error.gsub("this email address", email_address)
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
        email_addresses.each do |email_address|
          SimpleTeams::Invitation.create!(
            :team => team,
            :inviter => current_user,
            :role => role,
            :email_address => email_address
          )
        end
      end
    end

    def generate_notification
      SimpleTeams::BulkInvitationsNotification.with(
        :team_id => team.id,
        :user_id => current_user.id,
        :team_name => team.name,
        :user_name => current_user.full_name,
        :invitation_names => self.email_addresses,
      ).deliver_later(team.members)
    end

  end
end
