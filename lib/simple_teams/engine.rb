module SimpleTeams
  class Engine < ::Rails::Engine
    isolate_namespace SimpleTeams
  end

  mattr_accessor :member_class
  mattr_accessor :parent_controller
  mattr_accessor :layout

  def self.member_class
    (@@member_class || "User").constantize
  end

  def self.parent_controller
    (@@parent_controller || "ApplicationController").constantize
  end

  def self.layout
    (@@layout || "simple_teams/application")
  end

end
