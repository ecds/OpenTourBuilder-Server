# frozen_string_literal: true

# Model class for tour sets. This is the main model for "instances" of Open Tour Builder.
class TourSet < ApplicationRecord
  mount_uploader :logo, LogoUploader
  mount_uploader :footer_logo, LogoFooterUploader
  has_many :tour_set_admins
  has_many :admins, through: :tour_set_admins, source: :user
  before_save :set_subdir
  after_create :create_tenant
  after_create :create_defaults
  before_destroy :drop_tenant
  validates :name, presence: true, uniqueness: true
  # attr_accessor :footer_logo_width
  # attr_accessor :footer_logo_height
  attr_accessor :published_tours
  # validate :validate_footer_logo_dimensions, if :uploading?

  def published_tours
    begin
      Apartment::Tenant.switch! self.subdir
      tours = []
      Tour.published.each do |t|
        tour = {
          title: t.title,
          slug: t.slug
        }
        tours.push(tour)
      end
      tours
    rescue Apartment::TenantNotFound => error
      # self.delete
    end
  end

  private

    def set_subdir
      self.subdir = name.parameterize
    end

    def create_tenant
      Apartment::Tenant.create(subdir)
      # This is a bit of hack to fake the migrations from the
      # auth engine. Hopfully this will be replaced when we
      # redo the auth engine.
      Apartment::Tenant.reset
      schemas = ActiveRecord::SchemaMigration.all

      schemas.each do |schema|
        Apartment::Tenant.switch!(subdir)
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

    def symlink_logo
      FileUtils.mkdir "#{Rails.root}/public/uploads/#{self.subdir}"
      FileUtils.ln_s "#{Rails.root}/public/otblogo.png",
                      "#{Rails.root}/public/uploads/#{self.subdir}/otblogo.png"
      self.logo = 'otblogo.png'
      self.footer_logo = 'otblogo.png'
    end

    def uploading?
      footer_logo_width.present? && footer_logo_height.present?
    end

    def validate_footer_logo_dimensions
      ::Rails.logger.info "Footer logo upload dimensions: #{self.footer_logo_width}x#{self.footer_logo_height}"
      if self.footer_logo_width != footer_logo_height
        errors.add :footer_logo, 'Footer logo should be square'
      end
    end
end
