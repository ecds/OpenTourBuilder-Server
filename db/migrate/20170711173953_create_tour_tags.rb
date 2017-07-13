class CreateTourTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_tags do |t|
        t.string :title
        t.decimal :lat, precision: 100, scale: 8
        t.decimal :lng, precision: 100, scale: 8
        t.timestamps
    end
  end
end
