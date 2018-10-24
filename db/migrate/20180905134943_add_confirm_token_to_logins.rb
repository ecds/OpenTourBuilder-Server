class AddConfirmTokenToLogins < ActiveRecord::Migration[5.2]
  def change
    add_column :logins, :confirm_token, :string
  end
end
