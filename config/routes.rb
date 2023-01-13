Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  resources :courses do
    resources :lessons
  end
  root 'home#index'
  get 'home/activities'
  get 'static_pages/privacy_policy'
end
