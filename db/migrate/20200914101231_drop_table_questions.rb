class DropTableQuestions < ActiveRecord::Migration[6.0]
  def change
    drop_table :questions
    drop_table :game_questions
  end
end
