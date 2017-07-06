class CreateStopMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_media do |t|
        t.belongs_to :stop, index: true
        t.belongs_to :medium, index: true
      t.timestamps
    end
  end
end
