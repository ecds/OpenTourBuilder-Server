# frozen_string_literal: true

# Model for media associated with stops.
class Medium < ApplicationRecord
  mount_uploader :original_image, MediumUploader
  has_many :stop_media
  has_many :stops, through: :stop_media
end
