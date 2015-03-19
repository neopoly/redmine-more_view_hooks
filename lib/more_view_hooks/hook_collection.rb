module MoreViewHooks
  # Manages hooks to be applied into Redmine's templates
  class HookCollection
    def initialize
      @hooks   = {}
      @applied = false
    end

    # Applies all registered view hooks
    def apply!
      @hooks.values.each(&:apply!)
      @applied = true
    end

    # Registers a new view hook
    # @param name [String]
    # @param options [Hash] for Defaced
    def add(name, options)
      fail ArgumentError, "A view hook '#{name}' already exists" if @hooks[name]
      context = options.delete(:context)
      hook = @hooks[name] = Hook.new(name, context, options)
      hook.apply! if @applied
    end
  end
end
