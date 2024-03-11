module SimpleTeams
  class BulkInvitationsNotification < ApplicationNotification
    param :team_id, :user_id, :team_name, :user_name, :invitation_names

    def message
      "#{user_name} invited #{invitation_names.to_sentence} to #{team_name}."
    end

    def subject
      "Users Invited"
    end

    def url
      team_url(team, :subdomain => "app", :host => ENV['DOMAIN_NAME']) if team.present?
    end

    def link_text
      "View Invitations"
    end

    # Objects
    def team
      Teams::Team.find_by(id: params[:team_id])
    end

    def user
      SimpleTeams.member_class.find_by(id: params[:user_id])
    end

    # Names (fallback)
    def team_name
      team.present? ? team.name : params[:team_name]
    end

    def invitation_names
      params[:invitation_names]
    end

    def user_name
      if recipient.id == params[:user_id]
        "You"
      else
        user.present? ? user.full_name : params[:user_name]
      end
    end

  end
end
