# Model class for a tour stop.
class Stop < ApplicationRecord
    has_many :tour_stops
    has_many :tours, through: :tour_stops
    has_many :stop_media
    has_many :media, through: :stop_media

    validates :title, presence: true

end
