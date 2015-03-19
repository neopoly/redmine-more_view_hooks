module MoreViewHooks
  # Describes a preconfigured view hook which will be later applied
  # by using the elegant Deface gem
  class Hook
    attr_reader :deface_options

    def initialize(hook_name, context, options)
      @deface_options = options.merge(
        text: "<%= call_hook(:#{hook_name}, #{context || '{}'}) %>",
        name: "more_view_hooks_#{hook_name}"
      )
    end

    def apply!
      Deface::Override.new(deface_options)
    end
  end
end
