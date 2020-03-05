Rails.application.routes.draw do
  resources :companies, only: :index
  resources :industries, only: :index
  resources :cities, only: :index
  resources :jobs, only: [:index, :show] do
    collection do
      get "city/:city_id", action: :index, as: :city
      get "industry/:industry_id", action: :index, as: :industry
    end
  end
  get "apply", to: "jobs#apply"
  get "confirm", to: "jobs#confirm_apply"
  post "done", to: 'jobs#finish_apply'
  devise_for :users
  root "tops#index"
  namespace :users do
    resource :my_page, only: :show do
      collection do
        get "jobs", action: :applied_jobs, as: :applied_jobs
      end
    end
  end
  get "admin", to: "admins#index", as: :admin
end
