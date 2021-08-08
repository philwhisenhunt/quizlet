class Question < ApplicationRecord

    def check_answer(attempt)
        if attempt == @question.answer
            true 
        else
            false
        end
    end
end
