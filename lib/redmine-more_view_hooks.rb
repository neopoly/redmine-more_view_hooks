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

  require "more_view_hooks/default_additional_hooks"
end
