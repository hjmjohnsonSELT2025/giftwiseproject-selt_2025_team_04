Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
<<<<<<< HEAD
  root to: "home#index"
  get "/gifts" => "gifts#new", as: :new_gift
  post "/gifts" => "gifts#create", as: :create_gift
=======
  # root "posts#index"

  resources :events


>>>>>>> 5ba403fb568cfc94ea47ff59e5346189532bdb92

end
