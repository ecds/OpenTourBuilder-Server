# frozen_string_literal: true

# require 'apartment/elevators/subdomain'
require 'directory_elevator'
Apartment.configure do |config|
  # config.default_schema = 'public'
  config.excluded_models = %w{ TourSet Login User Role TourSetUser }
  config.tenant_names = -> { TourSet.pluck :subdir }
  config.excluded_models = ['Login', 'User', 'Role', 'TourSetUser', 'TourSet']
  # config.persistent_schemas = %w{ public }
end
DirectoryElevator
# Apartment::Elevators::Subdomain.excluded_subdomains = %w(www public)
