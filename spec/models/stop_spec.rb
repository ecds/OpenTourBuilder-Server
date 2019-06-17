# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stop, type: :model do
  it { should have_many(:tours) }
  it { should have_many(:tour_stops) }
  # it { should validate_presence_of(:title) }
  it { should have_many(:stop_media) }
  it { should have_many(:media) }
end
