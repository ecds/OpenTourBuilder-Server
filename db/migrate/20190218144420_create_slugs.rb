class CreateSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :slugs do |t|
      t.string :slug
      t.belongs_to :tour
      t.timestamps
    end
  end
end
