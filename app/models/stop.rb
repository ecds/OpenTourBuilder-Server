# frozen_string_literal: true

# Model class for a tour stop.
class Stop < ApplicationRecord
  include HtmlSaintizer

  has_many :tour_stops
  has_many :tours, through: :tour_stops
  has_many :stop_media
  has_many :media, through: :stop_media
  belongs_to :medium, optional: true

  validates :title, presence: true

  after_initialize :default_values

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
    if !stop_media.empty?
      return medium.nil? ? stop_media.order(:position).first.medium : medium
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
end
