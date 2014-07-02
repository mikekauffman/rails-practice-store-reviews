Rails.application.routes.draw do

  root to: 'products#index'

  resources :products

  resources :users

  resources :publishers

  resources :authors
  
  resources :charges

  get '/carts', to: 'carts#add'

  get '/carts/:id', to: 'carts#show', as: :cart

  post '/carts', to: 'carts#add'

  get '/login', to: 'sessions#new', as: :login

  post '/sessions', to: 'sessions#create', as: :new_session

  delete '/logout', to: 'sessions#destroy'

  get '/reset_password/new', to: 'reset_password#new', as: :new_reset_password

  post '/reset_password', to: 'reset_password#create'

  get '/reset_password', to: 'reset_password#edit', as: :edit_password

  post '/reset_password/update', to: 'reset_password#update'

end
