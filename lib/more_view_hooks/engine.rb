require "more_view_hooks/redmine_plugin"

module MoreViewHooks
  # Simple engine to support the Redmine plugin
  class Engine < ::Rails::Engine
    config.to_prepare do
      RedminePlugin.new
    end
  end
end
