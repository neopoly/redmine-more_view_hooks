module MoreViewHooks
  # Registers this gems a Redmine plugin and applies the needed patches
  class RedminePlugin
    include MoreViewHooks::Infos

    def initialize
      register!
      boot!
    end

    private

    def register!
      Redmine::Plugin.register :more_view_hooks do
        name NAME
        author AUTHORS.keys.join(", ")
        description DESCRIPTION
        version VERSION
        url URL
        author_url URL
        directory Engine.root
      end
    end

    def boot!
      MoreViewHooks.load_default_additional_hooks!
      MoreViewHooks.hooks.apply!
    end

    def mirror_assets!
      @plugin.mirror_assets
    end
  end
end
