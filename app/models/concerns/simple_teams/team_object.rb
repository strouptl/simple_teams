module SimpleTeams::TeamObject
  extend ActiveSupport::Concern

  included do
    attr_accessor :team_owner

    has_one :team, :as => :teamable, :class_name => "SimpleTeams::Team", :dependent => :destroy

    after_create :generate_team

    def self.team_object?
      true
    end

  end

  private

  def generate_team
    self.create_team!
  end

end
