Rails.application.routes.draw do
  resources :companies, only: :index
  resources :industries, only: :index
  resources :cities, only: :index
  resources :jobs, only: [:index, :show]
  get "jobs/city/:city_id", to: "jobs#index", as: :city_jobs
  get "jobs/industry/:industry_id", to: "jobs#index", as: :industry_jobs
  get "apply", to: "jobs#apply"
  devise_for :users
  root "tops#index"
  namespace :users do
    resource :my_page, only: :show
  end
end
