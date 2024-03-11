class Teams::TeamsController < TeamsController
  before_action :set_team

  def show
    authorize! :read, @team
    @memberships = @team.memberships.joins(:member).order(:first_name)
    @invitations = @team.invitations.initial.order(:email_address)
    @memberships_and_invitations = @memberships.to_a + @invitations.to_a
  end

  private

  def set_team
    @team = Teams::Team.find(params[:id])
  end

end
