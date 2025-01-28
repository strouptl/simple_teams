module SimpleTeams
  class Memberships::DestroyedNotifier < ApplicationNotifier
    include SimpleTeams::MembershipNotifier

    notification_methods do
      def message
        "#{user_name} removed #{member_name} from #{team_name}."
      end

      def subject
        "Member Removed"
      end
    end

  end
end
