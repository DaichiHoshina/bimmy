# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/new'
  root 'home#top'
  resources :users, only: %i[index new create show edit update]
end
