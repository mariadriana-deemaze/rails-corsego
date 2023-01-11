Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/activities'
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
end
