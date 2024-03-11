module SimpleTeams::MemberObject
  extend ActiveSupport::Concern

  included do
    has_many :team_memberships, :class_name => "SimpleTeams::Membership", :foreign_key => :member_id, :dependent => :destroy
    has_many :teams, :through => :team_memberships, :class_name => "SimpleTeams::Team"
    has_many :team_members, :through => :teams, :source => :members, :class_name => SimpleTeams.member_class.to_s
  end

  def member_of_team?(team)
    team_memberships.where(team: team).present?
  end

  def membership_for_team(team)
    team_memberships.find_by(:team_id => team.id)
  end

  def role_for_team(team)
    membership_for_team(team).role if membership_for_team(team).present?
  end

end
