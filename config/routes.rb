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
  resources :gift_suggestions, only: [:index, :new, :create]


  resources :events do
    resources :gift_suggestions, only: [:index, :create]
  end
  patch 'events/:id/invite', to: 'events#invite', as: 'event_invite'

  resources :recipients
  post 'recipients/remove_from_event', to: 'recipients#remove_from_event', as: 'remove_from_event'
  resource :user, only: [:show, :edit, :update]
  get 'friends/search', to: 'friends#search', as: :friends_search
  resources :friends, only: [:new, :index, :show]
  post 'friends/create_request', to: 'friends#create_request', as: :create_friend_request
  post 'friends/accept_request', to: 'friends#accept_request', as: :accept_friend_request
  post 'friends/decline_request', to: 'friends#decline_request', as: :decline_friend_request
  post 'friends/remove', to: 'friends#remove', as: :remove_friend
end
