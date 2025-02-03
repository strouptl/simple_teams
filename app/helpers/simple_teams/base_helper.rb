module SimpleTeams
  module BaseHelper
    def team_based_role_name(team, role)
      t "simple_teams.#{team.teamable.class.model_name.plural}.roles.names.#{role}", :default => [t("simple_teams.roles.names.#{role}")]
    end

    def team_based_role_description(team, role)
      t "simple_teams.#{team.teamable.class.model_name.plural}.roles.descriptions.#{role}", :default => [t("simple_teams.roles.descriptions.#{role}")]
    end
  end
end
