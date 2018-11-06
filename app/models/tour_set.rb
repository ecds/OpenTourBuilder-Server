# frozen_string_literal: true

# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
  has_many :tour_set_admins
  has_many :admins, through: :tour_set_admins, source: :user
  before_save :set_subdir
  after_create :create_tenant
  after_create :create_defaults
  before_destroy :drop_tenant

  validates :name, presence: true, uniqueness: true

    private

      def set_subdir
        self.subdir = name.parameterize
      end

      def create_tenant
        Apartment::Tenant.create(subdir)
        # This is a bit of hack to fake the migrations from the
        # auth engine. Hopfully this will be replaced when we
        # redo the auth engine.
        Apartment::Tenant.switch!('public')
        schemas = ActiveRecord::SchemaMigration.all

        Apartment::Tenant.switch!(subdir)
        schemas.each do |schema|
          migration = ActiveRecord::SchemaMigration.find_by_version(schema.version)
          if migration.nil?
            ActiveRecord::SchemaMigration.create(version: schema.version)
          end
        end
      end

      def create_defaults
        Apartment::Tenant.switch! subdir
        Mode.create([
          { title: 'BICYCLING', icon: 'bicycle' },
          { title: 'DRIVING', icon: 'car' },
          { title: 'TRANSIT', icon: 'subway' },
          { title: 'WALKING', icon: 'walking' }
        ])
        Theme.create([
          { title: 'dark' },
          { title: 'default' }
        ])
      end

      def drop_tenant
        Apartment::Tenant.drop(subdir)
      end
end
