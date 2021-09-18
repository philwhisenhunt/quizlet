class Quiz < ApplicationRecord
    has_many :quizzes_question
    has_many :questions, through: :quizzes_question
end
