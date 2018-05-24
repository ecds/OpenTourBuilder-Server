# frozen_string_literal: true

# Modle class for connecting stops to tours.
class TourStop < ApplicationRecord
  belongs_to :tour
  belongs_to :stop

  before_create do |tour_stop|
    tour_stop.position = Tour.find(tour_stop.tour_id).stops.length + 1
    # position = tour.stops.length + 1
  end

  def slug
    stop.title.parameterize
  end

  def next
    ts = self.class.where(tour_id: self.tour_id).where(position: self.position + 1).first
    ts.present? ? ts : nil
  end

  # Used for UIkit's Sticky component on the desktop vew. The media is sticky when scrolling until
  # the next stop comes along.
  def next_slug
    self.next.nil? ? nil : self.next.stop.slug
  end

  def previous
    ts = self.class.where(tour_id: self.tour_id).where(position: self.position - 1).first
    ts.present? ? ts : nil
  end
end
