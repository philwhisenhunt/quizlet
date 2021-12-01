class Quiz < ApplicationRecord
    # has_many :quizzes_question
    has_many :questions

    def gather_questions
    end
end
