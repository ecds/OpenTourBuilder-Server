# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should validate_presence_of(:title) }
  it { should have_many(:stops) }
  it { should have_many(:tour_stops) }
  it { Tour.reflect_on_association(:theme).macro.should eq(:belongs_to) }
  it { Tour.reflect_on_association(:mode).macro.should eq(:belongs_to) }
end
