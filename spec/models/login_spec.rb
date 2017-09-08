require 'rails_helper'

RSpec.describe Login, type: :model do
    # it { should belong_to(:user) }
    it { Login.reflect_on_association(:user).macro.should eq(:belongs_to) }
end
