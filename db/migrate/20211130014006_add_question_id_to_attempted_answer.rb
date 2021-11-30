class AddQuestionIdToAttemptedAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :attempted_answers, :question_id, :integer

  end
end
