# redmine-more_view_hooks

Allows adding more view hooks into Redmine's templates

## Installation

Ensure you have a `Gemfile.local` file in your Redmine installation. Add to your `Gemfile.local`:

```ruby
gem "redmine-more_view_hooks"
```

And then execute:

```
$ bundle
```

Restart the Redmine application

## Usage

Redmine already includes a concept of "view hooks", but not every place one can think already
as such a hook. E.g. a hook before the user login status in the top menu is missing.

Let's *assume* the needed view hook would already exists at the desired position and would be called `layout_base_logged_as_before`.
In this case one can simple write a new view hook listener as [natively supported from Redmine](http://www.redmine.org/projects/redmine/wiki/Hooks):

```ruby
class Hooks < Redmine::Hook::ViewListener
  # Redmine run's this method whenever a <%= call_hook(:layout_base_logged_as_before) %>
  # is included into the templates.
  # Attention: This view hook doesn't exists in Redmine and must be realized using this gem
  def layout_base_logged_as_before(context)
    content_tag :span, "Some additional content"
  ends
end
```

To bring this to live we need to add this new view hook into Redmine's base layout template.
Using this gem you can inject every needed view hooks into every possible template.
The needed hook can be achieved using the following statement:

```ruby
MoreViewHooks.add(
  # first the name of the new view hook
  :layout_base_logged_as_before,
  # now some Deface options to determine the correct position of the hook
  virtual_path:  "layouts/base",
  insert_before: "#top-menu erb[loud]:contains('if User.current.logged?'):contains('content_tag')"
)
```

For more information about the Deface options please have a look at [their documentation](https://github.com/spree/deface#usage).

The correct place to register new view hooks would be when initializing your Redmine plugin.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/redmine-more_view_hooks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
