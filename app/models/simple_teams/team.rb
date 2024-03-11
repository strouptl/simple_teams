module SimpleTeams
  class Team < ApplicationRecord

    # Polymorphic relationship
    belongs_to :teamable, polymorphic: true

    # Team Relationships
    has_many :invitations, :dependent => :destroy
    has_many :memberships, :dependent => :destroy
    has_many :members, :through => :memberships

    delegate :name, :to => :teamable

    def membership_for(member)
      memberships.find_by(:member_id => member.id)
    end

    def remove_member(member)
      memberships.find_by(:member_id => member.id).destroy
    end

  end
end
