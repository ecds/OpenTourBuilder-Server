# frozen_string_literal: true

# /app/models/tour_mode.rb
class TourMode < ApplicationRecord
  belongs_to :tour
  belongs_to :mode
end
