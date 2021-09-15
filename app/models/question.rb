class Question < ApplicationRecord
    
    belongs_to :quizzes_question
    has_many :quizzes, through: :quizzes_question
    def check_answer(attempt)
       
        if attempt == self.answer
            true 
        else
            false
        end
    end

    def mark_as_answered
      byebug # we are failing here because quizzes question must exist
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
