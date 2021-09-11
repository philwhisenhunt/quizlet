class CreateAnswersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :answers_tables do |t|
      add column :question, :answer, :string
      add_index :question, :answer
    end
  end
end
