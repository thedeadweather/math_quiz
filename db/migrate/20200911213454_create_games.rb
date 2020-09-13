class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.datetime :finished_at

      t.timestamps
    end
  end
end
