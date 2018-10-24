# frozen_string_literal: true

# Model class for a tour.
class Tour < ApplicationRecord
  include HtmlSaintizer
  has_many :tour_stops, autosave: true, dependent: :destroy
  has_many :stops, through: :tour_stops
  has_many :tour_modes
  has_many :modes, through: :tour_modes
  belongs_to :mode, default: -> { Mode.last }
  has_many :tour_media
  has_many :media, through: :tour_media
  belongs_to :medium, optional: true
  has_many :tour_flat_pages
  has_many :flat_pages, through: :tour_flat_pages
  has_many :tour_authors
  has_many :authors, through: :tour_authors, source: :user
  # has_many :authors, through: :tour_authors, foreign_key: :user_id

  # belongs_to :splash_image_medium_id, class_name: 'Medium'
  belongs_to :theme, default: -> { Theme.first }
  validates :title, presence: true

  before_validation -> { self.mode ||= Mode.last }
  before_validation -> { self.theme ||= Theme.first }
  before_validation -> { self.title ||= 'untitled' }

  scope :published, -> { where(published: true) }

  def sanitized_description
    HtmlSaintizer.accessable(description)
  end

  def slug
    title.parameterize
  end

  def tenant
    Apartment::Tenant.current
  end

  def theme_title
    theme.title
  end

  def splash
    if !tour_media.empty?
      return medium.nil? ? tour_media.order(:position).first.medium : medium
    end
    nil
  end
end
