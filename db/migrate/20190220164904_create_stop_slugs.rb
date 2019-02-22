class CreateStopSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :stop_slugs do |t|
      t.string :slug
      t.belongs_to :stop
      t.timestamps
    end
  end
end
