module SimpleTeams
  class Invitations::AcceptedNotifier < ApplicationNotifier
    include SimpleTeams::InvitationNotifier

    notification_methods do
      def message
        "#{user_name} accepted the invitation to #{team_name}."
      end

      def subject
        "Invitation Accepted"
      end
    end

  end
end
