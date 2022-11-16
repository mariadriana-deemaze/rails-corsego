Rails.application.routes.draw do
  root 'home#index'
  get 'static_pages/privacy_policy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  resources :courses
end
