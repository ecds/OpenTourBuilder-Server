# frozen_string_literal: true

# require 'apartment/elevators/subdomain'
require 'directory_elevator'
Apartment.configure do |config|
  config.tenant_names = -> { TourSet.pluck :subdir }
  config.excluded_models = ['Login', 'User', 'Role', 'TourSetAdmin', 'TourSet']
end
# DirectoryElevator
