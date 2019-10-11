# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#top'

  resources :users, only: %i[index new create show edit update]
  resources :posts, only: %i[index new create] do
    resource :favorite, only: %i[create destroy]
  end
  resources :favorites, only: %i[index]


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
