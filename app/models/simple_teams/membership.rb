module SimpleTeams
  class Membership < ApplicationRecord
    belongs_to :team
    belongs_to :member, :class_name => "User"
    has_one :invitation, :dependent => :nullify

    enum role: [:member, :administrator, :owner]

    validates_presence_of :role

    def role_to_s
      role.humanize.capitalize
    end

  end
end
