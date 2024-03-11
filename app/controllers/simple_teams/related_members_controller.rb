module SimpleTeams
  class RelatedMembersController < ApplicationController

    def index
      if params[:term].present?
        @members = SimpleTeams.member_class
          .joins(:team_memberships, :teams)
          .where("simple_teams_teams.id" => current_user.teams.pluck(:id))
          .where("email ilike ?", "%#{params[:term]}%")
          .order("#{SimpleTeams.member_class.table_name}.first_name")
          .uniq
        @members.reject! { |member| member.id == current_user.id }
      else
        @members= SimpleTeams.member_class.none
      end
    end

    def select2
      if params[:term].present?
        @members = SimpleTeams.member_class
          .joins(:team_memberships, :teams)
          .where("teams_teams.id" => current_user.teams.pluck(:id))
          .where("email ilike ?", "%#{params[:term]}%")
          .order("#{SimpleTeams.member_class.table_name}.first_name")
          .uniq
        @members.reject! { |member| member.id == current_user.id }
      else
        @members = SimpleTeams.member_class.none
      end
    end

  end
end
