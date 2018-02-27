# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'login' => 'authentication#login'
  resources :users, only: [:create]
end
