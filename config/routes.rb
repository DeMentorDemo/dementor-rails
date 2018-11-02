# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    post 'auth/login' => 'authentication#login'

    resources :users, only: [:index, :create, :update, :show]

    get 'current_user' => 'users#current'

    # Serve websocket cable requests in-process
    mount ActionCable.server => '/cable'
    resources :chats, only: [:index, :create] do
      resources :messages
    end
  end
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
