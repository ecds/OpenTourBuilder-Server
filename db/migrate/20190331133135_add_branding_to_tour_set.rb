class AddBrandingToTourSet < ActiveRecord::Migration[5.2]
  def change
    add_column :tour_sets, :logo, :string
    add_column :tour_sets, :footer_logo, :string
  end
end
