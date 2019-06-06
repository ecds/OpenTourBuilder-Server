class AddNotesToTourSet < ActiveRecord::Migration[5.2]
  def change
    add_column :tour_sets, :notes, :text
  end
end
