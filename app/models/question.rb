class Question < ApplicationRecord
    belongs_to :quiz
    def check_answer(attempt)
       
        if attempt == self.answer
            true 
        else
            false
        end
    end
end
