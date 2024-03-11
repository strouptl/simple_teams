module SimpleTeams
  class Invitations::DestroyedNotification < SimpleTeams::InvitationNotification

    def message
      "#{user_name} deleted the invitation for #{invitation_name} to #{team_name}."
    end

    def subject
      "Invitation Deleted"
    end

  end
end
