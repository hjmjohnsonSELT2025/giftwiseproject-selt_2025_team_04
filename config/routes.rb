Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "home#index"
  # get "/gifts" => "gifts#new", as: :new_gift
  # post "/gifts" => "gifts#create", as: :create_gift
  resources :gifts
  resources :gift_comments, only: [:new, :create, :edit, :update, :destroy]



  resources :events, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :recipients
  resource :user, only: [:show, :edit, :update]
  get 'friends/search', to: 'friends#search', as: :friends_search
  resources :friends, only: [:new, :index, :show]
  post 'friends/create_request', to: 'friends#create_request', as: :create_friend_request
  post 'friends/accept_request', to: 'friends#accept_request', as: :accept_friend_request
end
