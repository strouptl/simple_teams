module SimpleTeams
  class Memberships::LeftNotification < SimpleTeams::MembershipNotification

    def message
      if recipient.id == params[:member_id]
        "You left #{team_name}."
      else
        "#{member_name} left #{team_name}."
      end
    end

    def subject
      "Member Left"
    end

  end
end
