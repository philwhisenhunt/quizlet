class Question < ApplicationRecord

    def check_answer(attempt)
       
        if attempt == self.answer
            true 
        else
            false
        end
    end
end
