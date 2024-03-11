module SimpleTeams
  class Team < ApplicationRecord
    belongs_to :teamable, polymorphic: true
  end
end
