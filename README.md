[github]: https://github.com/neopoly/redmine-more_view_hooks
[doc]: http://rubydoc.info/github/neopoly/redmine-more_view_hooks/master/file/README.md
[gem]: https://rubygems.org/gems/redmine-more_view_hooks
[gem-badge]: https://img.shields.io/gem/v/redmine-more_view_hooks.svg
[inchpages]: https://inch-ci.org/github/neopoly/redmine-more_view_hooks
[inchpages-badge]: https://inch-ci.org/github/neopoly/redmine-more_view_hooks.svg?branch=master&style=flat

# redmine-more_view_hooks

[![Gem Version][gem-badge]][gem]
[![Inline docs][inchpages-badge]][inchpages]

[Gem][gem] |
[Source][github] |
[Documentation][doc]

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

Redmine already includes a concept of "view hooks", but not every place already
has such a hook. For example, a hook before the user login status in the top menu is missing.

Let's *assume* the needed view hook would already exists at the desired position and would be called `layout_base_logged_as_before`.
In this case one can simple write a new view hook listener as [natively supported from Redmine](http://www.redmine.org/projects/redmine/wiki/Hooks):

```ruby
class Hooks < Redmine::Hook::ViewListener
  # Redmine runs this method whenever a <%= call_hook(:layout_base_logged_as_before) %>
  # is included into the templates.
  # Attention: This view hook doesn't exists in Redmine and must be realized using this gem
  def layout_base_logged_as_before(context)
    content_tag :span, "Some additional content"
  end
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

### Avoiding hook definitions with identical names

Redmine allows multiple hook definitions with the identical name across separate hook listeners.

`MoreViewHooks.add` disallows hook definitions using the same name. So this won't work:

```ruby
MoreViewHooks.add(:unique_name, ...)

# raises "A view hook 'unique_name' already exists (ArgumentError)"
MoreViewHooks.add(:unique_name, ...)
```

Note: Defining a hook via `MoreViewHooks.add` re-using an existing Redmine hook name should work without problems.

Here is an example how to avoid duplicate hook names:

```ruby
unless Redmine::Hook.hook_listeners(:view_projects_show_left).any?
  MoreViewHooks.add(:view_projects_show_left,
    virtual_path: "projects/show",
    insert_top:   "div.contextual"
  )
end
```


## Contributing

1. Fork it ( https://github.com/neopoly/redmine-more_view_hooks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
