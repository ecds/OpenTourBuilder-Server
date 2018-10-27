# frozen_string_literal: true

# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
  has_many :tour_set_admins
  has_many :admins, through: :tour_set_admins
  before_save :set_subdir
  after_create :create_tenant
  after_create :create_defaults

  validates :name, presence: true, uniqueness: true

    private

      def set_subdir
        self.subdir = name.parameterize
      end

      def create_tenant
        Apartment::Tenant.create(subdir)
      end

      def create_defaults
        Apartment::Tenant.switch! subdir
        Mode.create([
          { title: 'BICYCLING' },
          { title: 'DRIVING' },
          { title: 'TRANSIT' },
          { title: 'WALKING' }
        ])
        Theme.create([
          { title: 'dark' },
          { title: 'default' }
        ])
      end
end
