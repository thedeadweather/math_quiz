class AddCorrectToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :correct, :integer, default: 0, null: false
    add_column :games, :incorrect, :integer, default: 0, null: false
    add_column :games, :attempt, :integer, null: false
  end
end
