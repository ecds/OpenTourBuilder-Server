# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TourMode, type: :model do
  it { should belong_to(:tour) }
  it { should belong_to(:mode) }
end
