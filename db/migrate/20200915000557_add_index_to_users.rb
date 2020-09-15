class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :users do |t|
      t.string   :reset_password_token
    end

    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
