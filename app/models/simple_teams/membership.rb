module SimpleTeams
  class Membership < ApplicationRecord
    belongs_to :team
    belongs_to :member
  end
end
