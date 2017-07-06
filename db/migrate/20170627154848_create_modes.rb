class CreateModes < ActiveRecord::Migration[5.1]
  def change
    create_table :modes do |t|
      t.string :title
      t.timestamps
    end
  end
end
