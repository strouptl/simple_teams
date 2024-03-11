module SimpleTeams
  class InvitationForms::Create < SimpleTeams::InvitationForm

    def initialize(team, current_user)
      @team = team
      @current_user = current_user
      @invitation = team.invitations.new(:inviter => @current_user)
    end

    private

    def generate_notification
      SimpleTeams::Invitations::CreatedNotification.with(
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
