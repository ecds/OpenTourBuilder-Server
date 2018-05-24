# frozen_string_literal: true

class FlatPage < ApplicationRecord
  has_many :tour_flat_pages
  has_many :tours, through: :tour_flat_pages
end
