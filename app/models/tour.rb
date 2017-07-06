# Model class for a tour.
class Tour < ApplicationRecord
    has_many :tour_stops
    has_many :stops, through: :tour_stops
    has_many :tour_modes
    has_many :modes, through: :tour_modes
    # belongs_to :tour_set
    belongs_to :theme
    validates :title, presence: true

    before_save :default_values

    def default_values
        self.theme = Theme.first
    end
end
