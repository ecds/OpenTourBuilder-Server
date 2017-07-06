require 'rails_helper'

RSpec.describe Theme, type: :model do
    it { should have_many(:tours) }
end
