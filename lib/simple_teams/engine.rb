module SimpleTeams
  class Engine < ::Rails::Engine
    isolate_namespace SimpleTeams
  end

  mattr_accessor :member_class
  mattr_accessor :parent_controller
  mattr_accessor :layout
  mattr_accessor :roles
  mattr_accessor :from_address

  def self.member_class
    (@@member_class || "User").constantize
  end

  def self.parent_controller
    (@@parent_controller || "ApplicationController").constantize
  end

  def self.layout
    (@@layout || "simple_teams/application")
  end

  def self.roles
    (@@roles || [:member, :administrator, :owner])
  end

  def self.from_address
    (@@from_address || "please-change-me@example.com")
  end

end
