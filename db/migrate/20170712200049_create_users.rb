class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
        t.string :displayname
        t.timestamps
    end
  end
end
