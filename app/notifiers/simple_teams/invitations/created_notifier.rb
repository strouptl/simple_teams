module SimpleTeams
  class Invitations::CreatedNotifier < ApplicationNotifier
    include SimpleTeams::InvitationNotifier

    notification_methods do
      def message
        "#{user_name} invited #{invitation_name} to #{team_name}."
      end

      def subject
        "User Invited"
      end
    end

  end
end
