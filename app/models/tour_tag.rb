class TourTag < ApplicationRecord
    validates :title, presence: true
end
