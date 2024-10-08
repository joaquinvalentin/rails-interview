class CompleteTodoListJob < ApplicationJob
  queue_as :default

  def perform(todo_list_id)
    TodoItem.where(todo_list_id:, completed: false).each do |todo_item|
      todo_item.update(completed: true)
      # To show a delay
      # sleep(1)
    end
  end
end
