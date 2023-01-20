Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  
  resources :users, only: [:index, :edit, :show, :update]
  
  resources :enrollments do 
    get :my_students, on: :collection
  end
  
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection

    member do
      patch :approve
      patch :unapprove
      patch :publish
      patch :unpublish
    end
    
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  
  get 'activity', to: 'home#activities'

  get 'statistics', to: 'home#statistics'
  
  namespace :charts do 
    get 'users_per_hour'
    get 'enrollments_per_day'
  end

  get 'static_pages/privacy_policy'
end
