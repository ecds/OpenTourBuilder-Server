# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mode, type: :model do
  it { should have_many(:tour_modes) }
  it { should have_many(:tours) }
end
