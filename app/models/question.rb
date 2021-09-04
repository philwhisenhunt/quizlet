class Question < ApplicationRecord
    # belongs_to :quiz
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

    def intro_new_quiz
        
    end
end
