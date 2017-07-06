class CreateTourModes < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_modes do |t|
        t.belongs_to :tour, index: true
        t.belongs_to :mode, index: true
      t.timestamps
    end
  end
end
