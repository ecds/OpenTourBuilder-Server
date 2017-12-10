# frozen_string_literal: true

# config/routes.rb
# The subdomain constraint determins the tenant.
class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w(www admin public)
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  constraints SubdomainConstraint do
    # namespace the controllers without affecting the URI
    # Additional version for testing
    scope module: :v1, constraints: ApiVersion.new('v1') do
      resources :tours, only: :index
    end
    scope module: :v3, constraints: ApiVersion.new('v3', true) do
      resources :users
      get 'users/me', to: 'users#me'
      resources :modes
      resources :tour_sets
      resources :themes
      resources :tours
      resources :media
      resources :stops
      resources :tour_stops, path: 'tour-stops'
    end
  end

  post '/v3/token', to: 'oauth2#create'
  post '/v3/revoke', to: 'oauth2#destroy'

end
