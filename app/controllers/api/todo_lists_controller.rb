module Api
  class TodoListsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :set_todo_list, only: %i[update destroy]

    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      respond_to :json
    end

    # POST /api/todolists
    def create
      @todo_list = TodoList.create(todolist_params)

      respond_to :json
    end

    # PUT /api/todolists/:id
    def update
      @todo_list.update(todolist_params)

      respond_to :json
    end

    # DELETE /api/todolists/:id
    def destroy
      @todo_list.destroy

      head :no_content
    end

    private

    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todolist_params
      params.require(:todo_list).permit(:name)
    end
  end
end
