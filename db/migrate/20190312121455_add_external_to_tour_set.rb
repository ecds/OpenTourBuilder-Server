class AddExternalToTourSet < ActiveRecord::Migration[5.2]
  def change
    add_column :tour_sets, :external_url, :string
  end
end
