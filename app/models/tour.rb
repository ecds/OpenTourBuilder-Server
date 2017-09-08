# Model class for a tour.
class Tour < ApplicationRecord
    has_many :tour_stops
    has_many :stops, through: :tour_stops
    has_many :tour_modes
    has_many :modes, through: :tour_modes
    belongs_to :mode, default: -> { Mode.last }
    # belongs_to :tour_set
    belongs_to :theme, default: -> { Theme.first }
    validates :title, presence: true

    before_validation -> { self.mode ||= Mode.last}
    before_validation -> { self.theme ||= Theme.first}

    # def default_values
    #     theme = Theme.first
    #     if is_geo
    #         return mode = Mode.first
    #     end
    #     self.mode = Mode.last
    # end
end
