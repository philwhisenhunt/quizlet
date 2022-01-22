class Quiz < ApplicationRecord
    # has_many :quizzes_question
    after_create_commit {broadcast_prepend_to :quizzes}
    has_many :questions

    def gather_questions
    end
end
