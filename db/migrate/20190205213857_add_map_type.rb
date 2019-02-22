class AddMapType < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :map_type, :string
  end
end
