module SimpleTeams
  class BaseController < SimpleTeams.parent_controller

    layout SimpleTeams.layout

    def current_ability
      SimpleTeams::Ability.new(current_user)
    end
    helper_method :current_ability

  end
end
