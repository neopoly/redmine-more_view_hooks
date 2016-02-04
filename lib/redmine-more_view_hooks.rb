require "deface"

require "more_view_hooks/version"
require "more_view_hooks/infos"
require "more_view_hooks/engine"
require "more_view_hooks/hook"
require "more_view_hooks/hook_collection"

# Redmine plugin to allow injecting more view hooks
module MoreViewHooks
  def hooks
    @hooks ||= HookCollection.new
  end
  module_function :hooks

  def add(*args)
    hooks.add(*args)
  end
  module_function :add

  def redmine_version_at_least?(other)
    Gem::Version.new(::Redmine::VERSION) > Gem::Version.new(other)
  end
  module_function :redmine_version_at_least?

  def load_default_additional_hooks!
    require "more_view_hooks/default_additional_hooks"
  end
  module_function :load_default_additional_hooks!
end
