class CreateAttemptedAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :attempted_answers do |t|
      t.string :attempted_answer
      t.boolean :correct_answer

      t.timestamps
    end
  end
end
