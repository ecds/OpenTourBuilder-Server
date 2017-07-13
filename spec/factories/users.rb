# spec/factories/users.rb
FactoryGirl.define do
    factory :user do
        displayname { Faker::Name.name }
        identification { Faker::Internet.free_email }
        uid { Faker::Number.number(10).to_s }
        provider { Faker::Name.name }
    end
end
