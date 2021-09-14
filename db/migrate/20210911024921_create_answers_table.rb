class CreateAnswersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :answers_tables do |t|
      add_column :answers, :question, :string
      add_column :answers, :answer, :string
      add_index :answers, :answer
    end
  end
end
