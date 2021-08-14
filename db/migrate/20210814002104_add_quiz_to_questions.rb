class AddQuizToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :quiz, index: true
    
  end
end
