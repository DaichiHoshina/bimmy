# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#top'

  resources :users, only: %i[index new create show edit update]
  resources :posts, only: %i[index new create edit update destroy] do
    resource :like, only: %i[create destroy]
    resource :map, only: %i[create show update]
  end
  resources :likes, only: %i[index]
  resources :maps, only: %i[index new create show update]
  resources :rankings, only: %i[index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
