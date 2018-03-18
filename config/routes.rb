# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # Authentication
  post 'auth/login' => 'authentication#login'

  # Users
  post 'users/signup' => 'users#create'
  get 'users/show' => 'users#show'
  get 'users' => 'users#index'
end
