Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "home#index"


  resources :events, only: [:show, :update, :destroy, :new, :create, :edit] do
   resources :gift_suggestions, only: [:index, :create]
  end
  
  resources :gifts
  resources :gift_comments, only: [:new, :create, :edit, :update, :destroy]


  resources :recipients

  resources :reminders, only: [:index, :new, :create]
  #resources :gifts

end
