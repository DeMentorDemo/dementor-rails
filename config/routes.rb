# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # Authentication
  post 'auth/login' => 'authentication#login'

  # Users
  resources :users, only: [:index, :create, :show]

  get 'current_user' => 'users#current_user'

  # Chats
  resources :chats, only: [:create]
end
