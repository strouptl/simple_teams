module SimpleTeams
  class Invitations::UpdatedNotification < SimpleTeams::InvitationNotification

    def message
      "#{user_name} updated the invitation for #{invitation_name} to #{team_name}."
    end

    def subject
      "Invitation Updated"
    end

  end
end
