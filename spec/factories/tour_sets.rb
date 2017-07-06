# spec/factories/tour_sets.rb
FactoryGirl.define do
    factory :tour_set do
        # This is to really make sure the name of the tenant is unique.
        name { Faker::Name.unique.name }
    end
end
