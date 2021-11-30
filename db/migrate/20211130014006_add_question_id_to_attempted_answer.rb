class AddQuestionIdToAttemptedAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :attempted_answer, :question_id, :integer

  end
end
