class CreateAnswersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :answers_tables do |t|
      add_column :questions, :answer, :string
      add_index :questions, :answer
    end
  end
end
