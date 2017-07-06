class CreateTourStops < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_stops do |t|
        t.belongs_to :tour, index: true
        t.belongs_to :stop, index: true
        t.integer :position
      t.timestamps
    end
  end
end
