module SimpleTeams
  class Membership < ApplicationRecord
    belongs_to :team
    belongs_to :member, :class_name => SimpleTeams.member_class.to_s
    has_one :invitation, :dependent => :nullify

    enum :role, SimpleTeams.roles

    validates_presence_of :role

    def role_to_s
      role.humanize.capitalize
    end

  end
end
