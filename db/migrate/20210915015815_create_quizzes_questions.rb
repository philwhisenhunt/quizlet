class CreateQuizzesQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes_questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
