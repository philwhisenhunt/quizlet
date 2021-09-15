class DropQuizzesQuestions < ActiveRecord::Migration[6.0]
  def change
    drop_table :quizzes_questions
  end
end
