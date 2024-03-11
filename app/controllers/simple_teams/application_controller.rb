module SimpleTeams
  class ApplicationController < SimpleTeams.parent_controller
    before_action :authenticate_user!

    layout SimpleTeams.layout

    def current_ability
      SimpleTeams::Ability.new(current_user)
    end
    helper_method :current_ability

  end
end
