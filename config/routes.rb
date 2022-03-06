# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: %i[new create index show edit destroy update]

  resources :users, only: %i[show create index edit update]
end
