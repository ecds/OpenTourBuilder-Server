# frozen_string_literal: true

#
# Through model TourSet and User assoiation.
#
class TourSetAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :tour_set
  belongs_to :role, default: -> { Role.where(title: 'Author').first }
end
