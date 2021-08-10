class AddAnsweredToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :Questions, :answered, :boolean
  end
end
