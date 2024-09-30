class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[show]

  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to do |format|
      format.html { render :new }
    end
  end

  # GET /todolists/:id
  def show
    respond_to :html
  end

  def create
    @todo_list = TodoList.create(todolist_params)

    respond_to do |format|
      format.html do
        redirect_to todo_list_path(@todo_list), notice: 'Todo list was successfully created.'
      end
    end
  end

  def complete_all
    CompleteTodoListJob.perform_later(params[:id])

    respond_to do |format|
      format.html { redirect_to todo_list_path(params[:id]), notice: 'Completing' }
    end
  end

  private

  def todolist_params
    params.require(:todo_list).permit(:name)
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end
end
