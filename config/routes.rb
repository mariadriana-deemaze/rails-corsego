Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  resources :enrollments
  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  root 'home#index'
  get 'home/activities'
  get 'static_pages/privacy_policy'
end
