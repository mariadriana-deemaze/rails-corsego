Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  
  resources :users, only: [:index, :edit, :show, :update]
  
  resources :enrollments do 
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end
  
  resources :tags, only: :create
  
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection

    member do
      get :analytics
      patch :approve
      patch :unapprove
      patch :publish
      patch :unpublish
    end
    
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
  end
  
  get 'activity', to: 'home#activities'

  get 'statistics', to: 'home#statistics'
  
  namespace :charts do 
    get 'users_per_hour'
    get 'enrollments_per_day'
  end

  post "webhooks", to: "webhooks#create"
  post "checkout/create", to: "checkouts#create"
  get "checkout/success", to: "checkouts#success"
  get "checkout/cancel", to: "checkouts#cancel"

  get 'static_pages/privacy_policy'
end
