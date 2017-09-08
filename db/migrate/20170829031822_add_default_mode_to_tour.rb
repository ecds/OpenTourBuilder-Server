class AddDefaultModeToTour < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :mode_id, :integer
    add_foreign_key :tours, :modes
  end
end
