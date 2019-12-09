Rails.application.routes.draw do
  resources :companies, only: :index
  resources :industries, only: :index
  resources :cities, only: :index
  resources :jobs, only: :index
  devise_for :users, controllers: {
    # sessions: 'users/sessions'
  }
  root "static_pages#index"
  get "static_pages/index"
  namespace :users do
    resource :my_page, only: :show
  end
end
