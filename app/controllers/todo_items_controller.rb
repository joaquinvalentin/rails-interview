class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[update destroy complete]

  def index
    @todo_items = TodoItem.where(todo_list_id: params[:todo_list_id])

    respond_to :html
  end

  def create
    @todo_item = TodoItem.new(todoitem_params)

    unless @todo_item.save
      flash[:error] = "Error creating todo item"
    end

    redirect_to todo_list_path(@todo_item.todo_list)
  end

  def complete
    @todo_item.update!(completed: true)
    
    respond_to do |format|
      format.html { redirect_to todo_list_path(@todo_item.todo_list) }
    end
  end

  def destroy
    @todo_item.destroy

    head :no_content
  end

  private

  def todoitem_params
    params.permit(:title, :completed, :todo_list_id)
  end

  def set_todo_item
    @todo_item = TodoItem.find_by(id: params[:id])
  end
end
