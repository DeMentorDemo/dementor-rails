# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # Authentication
  post 'auth/login' => 'authentication#login'

  # Users
  post 'users/signup' => 'users#create'
  get 'users/current_user' => 'users#current_user'
  get 'users/show/:id' => 'users#show'
  get 'users' => 'users#index'

  # Chats
  post 'chats/create' => 'chats#create'
end
