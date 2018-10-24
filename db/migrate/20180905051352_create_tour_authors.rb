class CreateTourAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_authors do |t|
      t.belongs_to :tour, index: true
      t.belongs_to :user, index: true
    end
  end
end
