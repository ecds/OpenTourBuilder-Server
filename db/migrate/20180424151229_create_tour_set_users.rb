class CreateTourSetUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :title
    end

    create_table :tour_set_admins do |t|
      t.belongs_to :tour_set, index: true
      t.belongs_to :user, index: true
      t.belongs_to :role, index: true
    end
  end
end
