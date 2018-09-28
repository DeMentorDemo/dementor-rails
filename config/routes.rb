# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    # Authentication
    post 'auth/login' => 'authentication#login'

    # Users
    resources :users, only: [:index, :create, :update, :show]

    get 'current_user' => 'users#current'

    # Chats
    resources :chats, only: [:index, :create]
  end
end
