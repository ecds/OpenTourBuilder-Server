# frozen_string_literal: true

# Model class for modes of directions, e.g. Walking, Biking, etc.
class Mode < ApplicationRecord
  has_many :tour_modes
  has_many :tours, through: :tour_modes
end
