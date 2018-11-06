# frozen_string_literal: true

# config/routes.rb
# The subdomain constraint determins the tenant.
# class SubdomainConstraint
#   def self.matches?(request)
#     subdomains = %w(www admin public)
#     request.subdomain.present? && !subdomains.include?(request.subdomain)
#   end
# end

Rails.application.routes.draw do

  resources :tour_set_admins
  scope ':tenant' do
    scope module: :v1, constraints: ApiVersion.new('v1') do
      resources :tours, only: :index
    end
    scope module: :v3, constraints: ApiVersion.new('v3', true) do
      resources :users
      resources :modes
      resources :tour_sets, path: 'tour-sets'
      resources :tour_set_admins, path: 'tour-set-users'
      resources :tour_collections, path: 'tour-collections'
      resources :tour_media, path: 'tour-media'
      resources :themes
      resources :tours
      resources :media
      resources :stops
      resources :stop_media, path: 'stop-media'
      resources :tour_media, path: 'tour-media'
      resources :tour_stops, path: 'tour-stops'
      resources :flat_pages, path: 'flat-pages'
      resources :tour_flat_pages, path: 'tour-flat-pages'
      resources :geojson_tours
    end
    post '/token', to: 'oauth2#create'
    post '/revoke', to: 'oauth2#destroy'
  end
end
