module SimpleTeams
  class Ability
    include ::CanCan::Ability

    def initialize(user)

      return unless user.present?

      can :create, Team

      # Team
      can :read, Team do |team|
        user.member_of_team?(team)
      end

      can [:update], Team do |team|
        %w"owner administrator".include? user.role_for_team(team)
      end

      can [:destroy], Team do |team|
        %w"owner".include? user.role_for_team(team)
      end

      # Team Memberships/Invitations
      can :read, [Membership, Invitation] do |object|
        user.member_of_team?(object.team)
      end

      can :manage, [Membership, Invitation] do |object|
        %w"owner administrator".include? user.role_for_team(object.team)
      end
    end
  end
end
