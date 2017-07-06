# Model for media associated with stops.
class Medium < ApplicationRecord
    has_many :stop_media
    has_many :stops, through: :stop_media
end
