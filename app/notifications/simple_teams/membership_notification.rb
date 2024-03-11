module SimpleTeams
  class MembershipNotification < ApplicationNotification
    param :team_id, :member_id, :user_id, :team_name, :member_name, :user_name

    def message
      raise NotImplemented
    end

    def subject
      raise NotImplemented
    end

    def url
      if team.present? and team.members.include? recipient
        "/teams/#{team.id}"
      end
    end

    def link_text
      "View Permissions"
    end

    # Objects
    def team
      Team.find_by(id: params[:team_id])
    end

    def user
      SimpleTeams.member_class.find_by(id: params[:user_id])
    end

    def member
      team.members.find_by(id: params[:member_id]) if team.present?
    end

    # Names (fallback)
    def team_name
      team.present? ? team.name : params[:team_name]
    end

    def member_name
      if recipient.id == params[:member_id]
        "you"
      else
        member.present? ? member.full_name : params[:member_name]
      end
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
