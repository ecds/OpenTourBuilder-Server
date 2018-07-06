class AddWidthAndHeightToMedium < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :desktop_width, :integer
    add_column :media, :desktop_height, :integer
    add_column :media, :tablet_width, :integer
    add_column :media, :tablet_height, :integer
    add_column :media, :mobile_width, :integer
    add_column :media, :mobile_height, :integer
  end
end
