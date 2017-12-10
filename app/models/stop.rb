# frozen_string_literal: true

# Model class for a tour stop.
class Stop < ApplicationRecord
  include HtmlSaintizer

  has_many :tour_stops
  has_many :tours, through: :tour_stops
  has_many :stop_media
  has_many :media, through: :stop_media

  validates :title, presence: true

  after_initialize :default_values

  def sanitized_description
    HtmlSaintizer.accessable(description)
  end

  private

    def default_values
      self.metadescription ||= HtmlSaintizer.accessable_truncated(self.description)
    end
end
