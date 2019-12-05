Rails.application.routes.draw do
  resources :companies
  resources :industries
  resources :cities
  resources :jobs
  devise_for :users
  root "static_pages#index"
  get "static_pages/index"
end
