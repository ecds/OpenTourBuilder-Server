# frozen_string_literal: true

# Model class for many to many assoition between stops and media
class StopMedium < ApplicationRecord
  belongs_to :medium
  belongs_to :stop
end
