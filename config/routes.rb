Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index create update], path: :todolists do
      resources :todo_items, only: %i[index create update destroy], path: :todos do
        put :complete, on: :member
      end
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
end
