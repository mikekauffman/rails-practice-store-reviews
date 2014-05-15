Rails.application.routes.draw do

  root to: 'products#index'

  resources :products

  resources :users

  resources :publishers

  resources :authors

  get '/login', to: 'sessions#new', as: :login

  post '/sessions', to: 'sessions#create', as: :new_session

end
