Rails.application.routes.draw do

  root 'users#index'

  resources :users

  get '/login', to: 'sessions#new', as: :login

  post  '/sessions', to: 'sessions#create', as: :new_session
end
