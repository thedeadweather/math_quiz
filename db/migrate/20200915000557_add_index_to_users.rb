class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :reset_password_token
  end
end
