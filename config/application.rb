# frozen_string_literal: true

# /config/application.rb
require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'
require 'apartment/elevators/subdomain'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OpenTourApi
  # Base class for the app.
  class Application < Rails::Application
    class DirectoryElevator < Apartment::Elevators::Generic
      def parse_tenant_name(request)
        # request is an instance of Rack::Request
        tenant_name = request.fullpath.split('/')[1]

        tenant_name
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    # config.middleware.use Apartment::Elevators::Subdomain
    config.middleware.use DirectoryElevator
    # config.relative_url_root = '/*'
  end
end