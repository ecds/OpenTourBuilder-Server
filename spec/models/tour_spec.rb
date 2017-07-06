require 'rails_helper'

RSpec.describe Tour, type: :model do
    it { should validate_presence_of(:title) }
    it { should have_many(:stops) }
    it { should have_many(:tour_stops) }
    # it { should belong_to(:theme) }
end
