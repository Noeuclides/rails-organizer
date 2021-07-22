class AddDescriptionAndDueDateToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :description, :text
    add_column :tasks, :due_date, :date
  end
end
