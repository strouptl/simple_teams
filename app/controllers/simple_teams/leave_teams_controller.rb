module SimpleTeams
  class LeaveTeamsController < BaseController
    before_action :set_team
    before_action :set_service_object

    def destroy
      if @service_object.valid? and @service_object.perform
        redirect_to main_app.url_for(@team.teamable.class), :notice => "You have successfully left the #{@team.name} #{@team.teamable.class.model_name.human}."
      else
        redirect_to team_path(@team), :notice => @service_object.errors[:user_id].first
      end
    end

    private

      def set_team
        @team = SimpleTeams::Team.find(params[:team_id])
      end

      def set_service_object
        @service_object = SimpleTeams::LeaveTeamService.new(current_user.id, @team.id)
      end

  end
end
