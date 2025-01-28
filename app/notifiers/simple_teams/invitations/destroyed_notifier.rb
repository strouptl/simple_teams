module SimpleTeams
  class Invitations::DestroyedNotifier < ApplicationNotifier
    include SimpleTeams::InvitationNotifier

    notification_methods do
      def message
        "#{user_name} deleted the invitation for #{invitation_name} to #{team_name}."
      end

      def subject
        "Invitation Deleted"
      end
    end

  end
end
