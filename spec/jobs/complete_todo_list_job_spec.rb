require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CompleteTodoListJob, type: :job do
  let(:todo_list) { create(:todo_list) }

  before do
    create_list(:todo_item, 3, completed: false, todo_list:)
  end

  it 'completes all todo items' do
    Sidekiq::Testing.inline! do
      described_class.perform_now(todo_list.id)
    end

    todo_list.todo_items.each do |todo_item|
      expect(todo_item.completed).to be true
    end
  end
end
