module Api
  class TodoItemsController < ApplicationController
    before_action :set_todo_item, only: %i[update destroy complete]

    # GET /api/todoitems
    def index
      @todo_items = TodoItem.where(todo_list_id: params[:todo_list_id])

      respond_to :json
    end

    # POST /api/todoitems
    def create
      @todo_item = TodoItem.create(todoitem_params)

      respond_to do |format|
        format.json { render "api/todo_items/show" }
      end
    end

    # PUT /api/todoitems/:id/complete
    def complete
      @todo_item.update(completed: true)

      respond_to do |format|
        format.json { render "api/todo_items/show" }
      end
    end

    def batch_complete
      #
      
    end

    # PUT /api/todoitems/:id
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
end
