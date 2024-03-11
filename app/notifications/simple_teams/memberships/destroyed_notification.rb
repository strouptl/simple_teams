module SimpleTeams
  class Memberships::DestroyedNotification < SimpleTeams::MembershipNotification

    def message
      "#{user_name} removed #{member_name} from #{team_name}."
    end

    def subject
      "Member Removed"
    end

  end
end
