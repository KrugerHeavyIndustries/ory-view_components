# Ory ViewComponents

Ory provide a full suite open-source identity and access management framework. It is often touted as cloud-native but itis highly configurable and adaptable for all kinds of environments.

Ory Kratos is an open-source, API-first identity and user management system written in Go. It acts as a headless authentication engine that handles core user lifecycle workflows such as registration, login, multi-factor authentication (MFA), account recovery, session management and profile updates (at least the parts relevant to identity).

The Ruby and Rails community has a number of options for providing this kind of funtionality but I am of the personal opinion that Ory is one of the more elegant solutions for these kinds of problems. However, whilst Ory provide many examples for adopting it with other languages and frameworks there isn't anything catered directly for it.

This is where Ory ViewComponents comes in.

Leveraging both ViewComponents and the Ory "protocol" and workflows, Ory ViewComponents is a Ruby on Rails engine that allows an application to make use of Kratos to provide the core identity and user management functionality.

## Quickstart (using docker)


### Spin up a Kratos instance

```shell
git clone https://github.com/ory/kratos.git
cd kratos
git checkout v26.2.0
docker compose -f quickstart.yml -f quickstart-standalone.yml up --force-recreate
```

### Run the Ory ViewComponents demo

```shell
cd demo/
bundle install
rails s
```

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
