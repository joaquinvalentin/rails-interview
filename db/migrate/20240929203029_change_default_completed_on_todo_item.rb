class ChangeDefaultCompletedOnTodoItem < ActiveRecord::Migration[7.0]
  def up
    change_column_default :todo_items, :completed, false

    execute "UPDATE todo_items SET completed = FALSE WHERE completed IS NULL"
  end

  def down
    change_column_default :todo_items, :completed, nil
  end
end
