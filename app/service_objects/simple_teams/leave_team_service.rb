module SimpleTeams
  class LeaveTeamService
    include ActiveModel::Model

    attr_accessor :user_id, :team_id

    def initialize(user_id, team_id)
      @user_id = user_id
      @team_id = team_id
    end

    def valid?
      self.errors.clear
      validate_not_last_owner
      !self.errors.any?
    end

    def perform
      membership.destroy
      generate_notification
    end

    def user
      @user ||= SimpleTeams.member_class.find(user_id)
    end

    def team
      @team ||= SimpleTeams::Team.find(team_id)
    end

    def membership
      @membership ||= user.membership_for_team(team)
    end

    private

    def validate_not_last_owner
      if membership.owner? and team.memberships.where(:role => :owner).count == 1
        self.errors.add(:user_id, "You must specify at least one other owner before leaving this #{team.teamable.class.model_name.human}.")
      end
    end

    def generate_notification
      recipients = team.members.to_a << user
      SimpleTeams::Memberships::LeftNotification.with(
        :team_id => team.id,
        :member_id => user.id,
        :user_id => user.id,
        :team_name => team.name,
        :member_name => user.full_name,
        :user_name => user.full_name
      ).deliver_later(recipients)
    end

  end
end
