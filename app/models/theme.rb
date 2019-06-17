# frozen_string_literal: true

# Model class for tour themes.
class Theme < ApplicationRecord
  has_many :tours
end
