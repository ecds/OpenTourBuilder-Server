# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StopMedium, type: :model do
  it { should belong_to(:stop) }
  it { should belong_to(:medium) }
end
