# OpenTourBuilder API Server

The OpenTourBuilder API server provides a multi-tenant REST API for geographic tours.

## Requirements

- Ruby 2.4.1+
- 5.2.x
- PostgreSQL 9.6.9
  - Plugins [^plugins]
    - pgcrypto
    - uuid-ossp
    - plpgsql

[^plugins]: Database plugins are enabled during the install process

## Build Status

Waiting to see how this will work with submodules.

## Installation

TODO: How does cloning work with submodules?
TODO: Note about rbenv.

~~~bash
bundle install
bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rake db:migrate
~~~

## Running local development server

Run the development under https to avoid mix content errors. Note: this will generate a self-signed certificate. There are ways to tell your browser to trust these certs, but that is beyond the scope of this README.

~~~bash
bundle exec puma -b 'ssl://0.0.0.0:3000?key=<path to key>&cert=<path to cert>
~~~

## Running tests

TODO: Add test coverage

~~~bash
bundle exec rspec ./spec
~~~

## Multitenancy

The OTB API sever uses the [Apartment](https://github.com/influitive/apartment) gem to support multitenancy.
TODO: Write blog post and link here.

## Endpoints

TODO: List REST endpoints

## Deployment

Use [Capistrano](https://capistranorb.com/) for deployment. General deployment configuration is defined in [deploy.rb](config/deploy.rb). Environment specific configurations can be found in [config/deploy](config/deploy).

Example:

~~~bash
cap deploy staging
~~~

## Contribute

We use the [Git-Flow](https://danielkummer.github.io/git-flow-cheatsheet/) branching model. Please submit pull requests against the develop branch.

### Code of conduct
[Code of Conduct](CODE_OF_CONDUCT.md)

## License

OpenTourBuilder API Server is released under the [MIT License](https://opensource.org/licenses/MIT).
