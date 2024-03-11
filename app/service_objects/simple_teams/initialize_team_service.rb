module SimpleTeams
  class InitializeTeamService

    attr_accessor :user, :team

    def initialize(user, team)
      @user = user
      @team = team
    end

    def valid?
      !user.teams.include? team
    end

    def perform
      ActiveRecord::Base.transaction do
        team.memberships.create(
          :member => user,
          :role => :owner
        )
      end
    end

  end
end
