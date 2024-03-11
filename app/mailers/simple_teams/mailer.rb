module SimpleTeams
  class Mailer < ApplicationMailer

    def invitation_notification(invitation)
      @invitation = invitation
      @name = invitation.team.name
      @resource_name = invitation.team.teamable.class.model_name.human
      @invitation_url = accept_team_invitation_url(@invitation.token)

      mail(
        to: (@invitation.email_address),
        subject: "Invitation to #{@name} #{@resource_name}"
      )
    end

  end
end
