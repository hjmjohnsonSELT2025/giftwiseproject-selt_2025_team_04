
Rails.application.routes.draw do




  resources :gift_suggestions, only: [:new, :create]
  resources :reminders, only: [:index, :new, :create]

  root "gift_suggestions#new"

  #get 'nick_sprint1_demo', to: 'nick_sprint1_demo/index'
  # get 'reminders/index'
  #get 'reminders/create'
  # get 'gift_suggestions/create'

  # root "posts#index"
end
