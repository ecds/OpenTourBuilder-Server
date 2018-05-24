# frozen_string_literal: true

# /app/models/tour_mode.rb
class TourFlatPage < ApplicationRecord
  belongs_to :tour
  belongs_to :flat_page
end
