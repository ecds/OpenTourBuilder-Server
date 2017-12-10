# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Login, type: :model do
  it { expect(Login.reflect_on_association(:user).macro).to eq(:belongs_to) }
end
