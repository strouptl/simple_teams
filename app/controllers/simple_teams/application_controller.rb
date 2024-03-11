module SimpleTeams
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def current_ability
      SimpleTeams::Ability.new(current_user)
    end
    helper_method :current_ability

  end
end
