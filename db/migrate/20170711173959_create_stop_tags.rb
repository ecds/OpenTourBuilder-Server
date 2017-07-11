class CreateStopTags < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_tags do |t|
      t.string :title
      t.timestamps
    end
  end
end
