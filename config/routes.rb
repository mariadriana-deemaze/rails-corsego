Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  resources :courses
  resources :lessons
  root 'home#index'
  get 'home/activities'
end
