# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
    after_create :create_tenant

    validates :name, presence: true

    def subdomain
        return name.parameterize
    end

    private

    def create_tenant
        Apartment::Tenant.create(subdomain)
    end
end
