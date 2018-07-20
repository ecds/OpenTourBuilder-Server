class ChangeTourSetSubdomainToSubdir < ActiveRecord::Migration[5.2]
  def change
    rename_column :tour_sets, :subdomain, :subdir
  end
end
