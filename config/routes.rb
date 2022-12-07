Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'static_pages/privacy_policy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  resources :courses
  resources :users
end
