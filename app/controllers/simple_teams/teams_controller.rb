module SimpleTeams
  class TeamsController < BaseController
    before_action :set_team

    def show
      authorize! :read, @team
      @memberships = @team.memberships.joins(:member).order(:first_name)
      @invitations = @team.invitations.initial.order(:email)
      @memberships_and_invitations = @memberships.to_a + @invitations.to_a
    end

    private

    def set_team
      @team = SimpleTeams::Team.find(params[:id])
    end

  end
end
