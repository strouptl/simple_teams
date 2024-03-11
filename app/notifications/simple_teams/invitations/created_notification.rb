module SimpleTeams
  class Invitations::CreatedNotification < SimpleTeams::InvitationNotification

    def message
      "#{user_name} invited #{invitation_name} to #{team_name}."
    end

    def subject
      "User Invited"
    end

  end
end
