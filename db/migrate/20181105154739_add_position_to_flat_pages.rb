class AddPositionToFlatPages < ActiveRecord::Migration[5.2]
  def change
    add_column :tour_flat_pages, :position, :integer
  end
end
