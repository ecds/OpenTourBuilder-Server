# frozen_string_literal: true

# Model class for a tour stop.
class Stop < ApplicationRecord
  include HtmlSaintizer

  has_many :tour_stops, dependent: :destroy
  has_many :tours, through: :tour_stops
  has_many :stop_media
  has_many :media, through: :stop_media
  belongs_to :medium, optional: true
  has_many :stop_slugs, dependent: :delete_all

  validates :title, presence: true

  after_initialize :default_values
  after_save :ensure_slug

  before_validation -> { self.title ||= 'untitled' }

  scope :not_in_tour, lambda { |tour_id| includes(:tour_stops).where.not(tour_stops: { tour_id: tour_id }) }
  scope :no_tours, lambda { includes(:tour_stops).where(tour_stops: { tour_id: nil }) }
  scope :published, lambda { includes(:tours).where(tours: { published: true }) }

  def sanitized_description
    HtmlSaintizer.accessable(description)
  end

  def sanitized_direction_notes
    HtmlSaintizer.accessable(direction_notes)
  end

  def slug
    title.parameterize
  end

  def splash
    if medium.present?
      return medium
    elsif stop_media.present?
      return stop_media.order(:position).first.medium
    end
    nil
  end

  def splash_height
    splash.nil? ? nil : splash.desktop_height
  end

  def splash_width
    splash.nil? ? nil : splash.desktop_width
  end

  def insecure_splash
    if !stop_media.empty?
      return medium.nil? ? stop_media.order(:position).first.medium.insecure : medium.insecure
    end
    nil
  end

  def is_published
    tours.published.present?
  end


  private

    def default_values
      self.metadescription ||= HtmlSaintizer.accessable_truncated(self.description)
    end

    def ensure_slug
      StopSlug.find_or_create_by(slug: self.slug, stop: self)
    end
end
