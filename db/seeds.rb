# frozen_string_literal: true

# Trasportation modes depend on Google's avaliable options. Note, we are skipping flight directions.
# Mode.destroy_all

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
