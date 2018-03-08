# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/login' => 'authentication#login'

  # users_controller
  post 'users/signup' => 'users#create'
  get 'users/show' => 'users#show'
end
