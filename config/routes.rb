# config/routes.rb
class SubdomainConstraint
    def self.matches?(request)
        subdomains = %w(www admin public)
        request.subdomain.present? && !subdomains.include?(request.subdomain)
    end
end

Rails.application.routes.draw do
    constraints SubdomainConstraint do
        resources :modes
        resources :tour_sets
        resources :themes
        resources :tours do
            resources :stops do
                resources :media
            end
        end
        # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
end
