module SimpleTeams
  class RelatedUsersController < ApplicationController

    def index
      if params[:term].present?
        @users = User
          .joins(:team_memberships, :teams)
          .where("teams_teams.id" => current_user.teams.pluck(:id))
          .where("email ilike ?", "%#{params[:term]}%")
          .order("users.first_name")
          .uniq
        @users.reject! { |user| user.id == current_user.id }
      else
        @users = User.none
      end
    end

    def select2
      if params[:term].present?
        @users = User
          .joins(:team_memberships, :teams)
          .where("teams_teams.id" => current_user.teams.pluck(:id))
          .where("email ilike ?", "%#{params[:term]}%")
          .order("users.first_name")
          .uniq
        @users.reject! { |user| user.id == current_user.id }
      else
        @users = User.none
      end
    end

  end
end
