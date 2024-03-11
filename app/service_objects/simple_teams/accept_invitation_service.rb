module SimpleTeams
  class AcceptInvitationService
    include ActiveModel::Model

    attr_accessor :user_id, :invitation_token

    def initialize(user_id, invitation_token)
      @user_id = user_id
      @invitation_token  = invitation_token
    end

    def valid?
      self.errors.clear
      validate_invitation_token
      validate_user_not_a_member
      !self.errors.any?
    end

    def perform
      ActiveRecord::Base.transaction do
        membership = team.memberships.create!(
          :member => user,
          :role => invitation.role
        )
        invitation.update!(membership: membership)
        invitation.accepted!
      end
    end

    def user
      @user ||= User.find(user_id)
    end

    def invitation
      @invitation ||= Teams::Invitation.find_by(token: @invitation_token)
    end

    private

    def team
      invitation.team
    end

    def validate_invitation_token
      if invitation.blank?
        self.errors.add(:invitation_token, "That invitation token is not valid.")
      elsif !invitation.initial?
        self.errors.add(:invitation_token, "That invitation token has already been used. If you believe this is in error, please contact the team administrator to send you a new invitation.")
      elsif invitation.expired?
        self.errors.add(:invitation_token, "That invitation token is expired. Please contact the team administrator to resend your invitation.")
      end
    end

    def validate_user_not_a_member
      if user.teams.include? invitation.team
        self.errors.add(:user_id, "You are already a member of this team.")
      end
    end

  end
end
