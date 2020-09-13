class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.boolean :correct, default: false, null: false
      t.timestamps
    end
  end
end
