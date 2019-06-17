# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Medium, type: :model do
  it { should have_many(:stop_media) }
  it { should have_many(:stops) }
end
