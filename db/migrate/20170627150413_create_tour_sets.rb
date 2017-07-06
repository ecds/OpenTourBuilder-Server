class CreateTourSets < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_sets do |t|
      t.string :name
      t.timestamps
    end
  end
end
