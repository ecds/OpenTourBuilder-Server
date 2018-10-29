# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TourStop, type: :model do
  it { should belong_to(:tour) }
  it { should belong_to(:stop) }
  it "is not valid without a title"
end
