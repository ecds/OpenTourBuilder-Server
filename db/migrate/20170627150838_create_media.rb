class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :title
      t.text :caption
      t.string :original_image
      t.timestamps
    end
  end
end
