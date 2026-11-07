# Ory View Components

## Customizing views

Copy the default views and layout into your application:

```sh
bin/rails generate ory_view_components:views
```

Files in your application take priority over the engine's, matched by path. Delete any copies you don't change so they keep receiving updates from the gem.

To change the markup of the components as well, add `--components`:

```sh
bin/rails generate ory_view_components:views --components
```

To override a component, your application needs both its Ruby class and its template, such as `app/components/ory/card_component.rb` and `app/components/ory/card_component.html.erb`. A copied template without its class is ignored.
