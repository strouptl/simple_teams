module SimpleTeams
  module BaseHelper
    def team_based_role_name(team, role)
      t "simple_teams.#{team.teamable.class.to_s.underscore}.role_names.#{role}", :default => [t("simple_teams.role_names.#{role}")]
    end

    def team_based_role_description(team, role)
      t "simple_teams.#{team.teamable.class.to_s.underscore}.role_descriptions.#{role}", :default => [t("simple_teams.role_descriptions.#{role}")]
    end
  end
end
