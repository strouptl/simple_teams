module SimpleTeams
  class Invitations::AcceptedNotification < SimpleTeams::InvitationNotification

    def message
      "#{user_name} accepted the invitation to #{team_name}."
    end

    def subject
      "Invitation Accepted"
    end

  end
end
