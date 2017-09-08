# /app/models/tour_mode.rb
class TourMode < ApplicationRecord
    belongs_to :tour
    belongs_to :mode
end
