module SimpleTeams
  class Memberships::UpdatedNotifier < ApplicationNotifier
    include SimpleTeams::MembershipNotifier

    notification_methods do
      def message
        if recipient.id == params[:member_id]
          "#{user_name} updated your role for #{team_name}."
        else
          "#{user_name} updated the role of #{member_name} for #{team_name}."
        end
      end

      def subject
        "Member Updated"
      end
    end

  end
end
