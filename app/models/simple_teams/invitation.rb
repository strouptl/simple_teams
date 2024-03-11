module SimpleTeams
  class Invitation < ApplicationRecord
    belongs_to :team
    belongs_to :inviter
    belongs_to :membership
  end
end
