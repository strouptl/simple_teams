module SimpleTeams
  class Invitations::UpdatedNotifier < ApplicationNotifier
    include SimpleTeams::InvitationNotifier

    notification_methods do
      def message
        "#{user_name} updated the invitation for #{invitation_name} to #{team_name}."
      end

      def subject
        "Invitation Updated"
      end
    end

  end
end
