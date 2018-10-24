class RenameTourSet < ActiveRecord::Migration[5.2]
  def change
    rename_table :tour_set_admins, :tour_set_admins
  end
end
