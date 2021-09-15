class Quiz < ApplicationRecord
    belongs_to :quizzes_question
    has_many :questions, through: :quizzes_question
end
