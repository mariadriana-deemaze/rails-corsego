Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  resources :enrollments do 
    get :my_students, on: :collection
  end
  resources :courses do
    get :purchased, :created, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  root 'home#index'
  get 'activity', to: 'home#activities'
  get 'statistics', to: 'home#statistics'
  get 'static_pages/privacy_policy'
end
