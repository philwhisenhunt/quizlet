class AddAnsweredToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :answered, :boolean
  end
end
