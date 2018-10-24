# frozen_string_literal: true

# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
  has_many :tour_set_admins
  has_many :admins, through: :tour_set_admins
  before_save :set_subdir
  after_create :create_tenant

  validates :name, presence: true, uniqueness: true

    private

      def set_subdir
        self.subdir = name.parameterize
      end

      def create_tenant
        Apartment::Tenant.create(subdir)
      end
end
