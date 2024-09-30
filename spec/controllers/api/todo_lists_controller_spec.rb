require 'rails_helper'

describe Api::TodoListsController do # rubocop:disable Metrics/BlockLength
  render_views

  describe 'GET #index' do
    let!(:todo_list) { create(:todo_list) }

    context 'when format is HTML' do
      it 'raises a routing error' do
        expect do
          get :index
        end.to raise_error(ActionController::RoutingError, 'Not supported format')
      end
    end

    context 'when format is JSON' do
      before do
        get :index, format: :json
      end

      it 'returns a success code' do
        expect(response.status).to eq(200)
      end

      it 'includes todo list records' do
        todo_lists = JSON.parse(response.body)

        aggregate_failures 'includes the id and name' do
          expect(todo_lists.count).to eq(1)
          expect(todo_lists[0].keys).to match_array(%w[id name])
          expect(todo_lists[0]['id']).to eq(todo_list.id)
          expect(todo_lists[0]['name']).to eq(todo_list.name)
        end
      end
    end
  end

  describe 'GET show' do
    let!(:todo_list) { create(:todo_list, :with_todo_items) }

    context 'when format is HTML' do
      it 'raises a routing error' do
        expect do
          get :show, params: { id: todo_list.id }, format: :html
        end.to raise_error(ActionController::RoutingError, 'Not supported format')
      end
    end

    context 'when format is JSON' do
      before do
        get :show, params: { id: todo_list.id }, format: :json
      end

      it 'returns a success code' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST #create' do
    context 'when format is HTML' do
      it 'raises a routing error' do
        expect do
          post :create, params: { todo_list: { name: 'Setup RoR project' } }, format: :html
        end.to raise_error(ActionController::RoutingError, 'Not supported format')
      end
    end

    context 'when format is JSON' do
      before do
        post :create, params: { todo_list: { name: 'Setup RoR project' } }, format: :json
      end

      it 'returns a success code' do
        post :create, params: { todo_list: { name: 'Setup RoR project' } }, format: :json

        expect(response.status).to eq(200)
      end

      it 'creates a new todo list' do
        expect do
          post :create, params: { todo_list: { name: 'Setup RoR project' } }, format: :json
        end.to change(TodoList, :count).by(1)
      end
    end
  end
end
