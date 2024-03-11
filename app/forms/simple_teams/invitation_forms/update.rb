module SimpleTeams
  class InvitationForms::Update < SimpleTeams::InvitationForm

    def initialize(invitation, current_user)
      @invitation = invitation
      @team = @invitation.team
      @current_user = current_user

      # Get existing attributes
      self.class.invitation_attributes.each do |a|
        self.assign_attributes(a => @invitation.send(a))
      end
    end

    private

    def generate_notification
      SimpleTeams::Invitations::UpdatedNotification.with(
        :team_id => team.id,
        :invitation_id => invitation.id,
        :user_id => current_user.id,
        :team_name => team.name,
        :invitation_name => invitation.email_address,
        :user_name => current_user.full_name
      ).deliver_later(team.members)
    end

  end
end
