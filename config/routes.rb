# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'

  root 'home#top'

  resources :users, only: %i[index new create show edit update]
  resources :posts, only: %i[index new create show edit update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
