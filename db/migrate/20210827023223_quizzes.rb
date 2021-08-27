class Quizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes_questions, :id => false do |t|
      t.integer :quiz_id
      t.integer :question_id
    end
  end
end
