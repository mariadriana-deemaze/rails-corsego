Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  resources :courses do
    resources :lessons
  end
  root 'home#index'
  get 'home/activities'
end
