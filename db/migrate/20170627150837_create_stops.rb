class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :title
      t.text :description
      t.string :metadescription, limit: 500
      t.string :article_link
      t.string :video_embed
      t.string :video_poster
      t.decimal :lat, precision: 100, scale: 8
      t.decimal :lng, precision: 100, scale: 8
      t.decimal :parking_lat, precision: 100, scale: 8
      t.decimal :parking_lng, precision: 100, scale: 8
      t.text :direction_intro
      t.text :direction_notes

      t.timestamps
    end
  end
end
