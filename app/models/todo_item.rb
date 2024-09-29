class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :title, presence: true

  after_update_commit :broadcast_update_if_completed

  private

  def broadcast_update_if_completed
    puts "Broadcasting update of todo_item #{id}"

    Turbo::StreamsChannel.broadcast_replace_to(
      "todo_list_#{todo_list.id}",
      target: "todo_item_#{id}",
      partial: "todo_items/todo_item",
      locals: { todo_item: self }
    )
  end
end
