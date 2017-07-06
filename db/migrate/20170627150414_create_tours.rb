class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string :title
      t.text :description
      t.string :splash_image
      t.boolean :is_geo
      t.boolean :published
      t.belongs_to :theme, index: true
      t.timestamps
    end
  end
end
