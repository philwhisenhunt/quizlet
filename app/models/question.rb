class Question < ApplicationRecord
    
    # belongs_to :quizzes_question
    has_many :quizzes_questions
    has_many :quizzes, through: :quizzes_question

    after_create_commit { broadcast_prepend_to :questions}
    def check_answer(attempt)
       
        if attempt == self.answer
            true 
        else
            false
        end
    end

    def mark_as_answered
        self.answered = true
        self.save
    end

    def mark_as_unanswered
        self.answered = false
        self.save
    end

    def correct_answer
        self.answer
    end

   
end
