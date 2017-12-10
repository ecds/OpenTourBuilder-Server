# frozen_string_literal: true

# Modle class for connecting stops to tours.
class TourStop < ApplicationRecord
  belongs_to :tour
  belongs_to :stop

  before_create do |tour_stop|
    tour_stop.position = Tour.find(tour_stop.tour_id).stops.length + 1
  end

  def slug
    stop.title.parameterize
  end
end
