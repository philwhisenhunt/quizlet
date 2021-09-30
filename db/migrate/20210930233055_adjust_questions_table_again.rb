class AdjustQuestionsTableAgain < ActiveRecord::Migration[6.0]
  def change
    change_column_null :questions, :answer, false, "a"

  end
end
