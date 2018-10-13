# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    post 'auth/login' => 'authentication#login'

    resources :users, only: [:index, :create, :update, :show]

    get 'current_user' => 'users#current'

    resources :chats, only: [:index, :create] do
      resources :messages
    end
  end
end
