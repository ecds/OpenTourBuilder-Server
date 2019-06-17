# frozen_string_literal: true

# Model class for many to many assoition between stops and media
class TourMedium < ApplicationRecord
  belongs_to :medium
  belongs_to :tour
  # validates :position, presence: true

  after_create do
    self.position = self.tour.media.length + 1
    self.save
  end

  before_destroy do
    if self.medium.nil? || self.tour.nil?
      nil
    else
      self.medium.tours.length == 1 ? self.medium.destroy! : nil
    end
  end
end
