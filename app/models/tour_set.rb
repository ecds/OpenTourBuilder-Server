# frozen_string_literal: true

# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
  before_save :set_subdomain
  after_create :create_tenant

  validates :name, presence: true
  attribute subdomain: name.parameterize

    private

      def set_subdomain
        self.subdomain = name.parameterize
      end

      def create_tenant
        Apartment::Tenant.create(subdomain)
      end
end
