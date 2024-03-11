module SimpleTeams
  class Engine < ::Rails::Engine
    isolate_namespace SimpleTeams
  end

  mattr_accessor :member_class

  def self.member_class
    (@@member_class || "User").constantize
  end

end
