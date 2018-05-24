# frozen_string_literal: true

# Model class for many to many assoition between stops and media
class StopMedium < ApplicationRecord
  belongs_to :medium
  belongs_to :stop

  after_create do
    self.position = self.position.nil? ? self.stop.media.length : self.position
    self.save
  end

  before_destroy do
    if self.medium.nil? || self.stop.nil?
      nil
    else
      self.medium.stops.length == 1 ? self.medium.destroy! : nil
    end
  end
end
