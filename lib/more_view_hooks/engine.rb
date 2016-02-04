require "more_view_hooks/redmine_plugin"

module MoreViewHooks
  # Simple engine to support the Redmine plugin
  class Engine < ::Rails::Engine
    config.to_prepare do
      RedminePlugin.new
    end

    initializer "hotfix.redmine_plugins_eager_load_paths",
                before: "deface.tweak_eager_loading" do |app|
      patch_redmine_plugins_eager_load_paths!(app)
    end

    private

    def patch_redmine_plugins_eager_load_paths!(app)
      app.railties._all.each do |railtie|
        next unless railtie.respond_to?(:root) &&
                    railtie.config.respond_to?(:eager_load_paths)
        railtie.config.eager_load_paths.map!(&:to_s)
      end
    end
  end
end
