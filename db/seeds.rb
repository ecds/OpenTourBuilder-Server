# frozen_string_literal: true

# Trasportation modes depend on Google's avaliable options. Note, we are skipping flight directions.
# Mode.destroy_all

# include FactoryBot
require 'factory_bot_rails'
require 'faker'

Mode.create!(
  [
    {
        title: 'Walk'
    },
    {
        title: 'Bike'
    },
    {
        title: 'Transit'
    },
    {
        title: 'Drive'
    },
    {
        title: 'None'
    }
  ]
)

# Role.destroy_all

Role.create!(
  [
    {
      title: 'Super'
    },
    {
      title: 'Tour Admin'
    },
    {
      title: 'Author'
    }
  ]
)

3.times { FactoryBot.create(:tour_set) }

4.times do
  # User.create(display_name: Faker::Movies::Lebowski)
  FactoryBot.create(:login)
  Login.last.user.update_attribute(:display_name, Faker::Movies::Lebowski)
end

TourSet.all.each do |ts|
  Apartment::Tenant.switch!(ts.subdir)
  Random.new.rand(2..3).times do
    FactoryBot.create(:tour)
    Tour.all.each do |tour|
      FactoryBot.create_list(:stop, Random.new.rand(3..4))
      tour.stops << Stop.all
    end
  end
  Apartment::Tenant.reset
end

User.where(super: false).order(Arel.sql('random()')).limit(6).each do |u|
  u.tour_sets << TourSet.all.order(Arel.sql('random()')).limit(1).first
  u.tour_set_admins.each do |ur|
    ur.role = Role.find_by(title: 'Tour Admin')
    ur.save
  end
  u.save
end

User.all.each do |u|
  next if u.super
  next if u.tours.present?
  u.tours = Tour.all.order(Arel.sql('random()')).limit(Random.new.rand(2..3))
  u.save
end

User.all.order(Arel.sql('random()')).first.update_attribute(:super, true)
