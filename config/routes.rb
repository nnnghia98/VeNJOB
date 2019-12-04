Rails.application.routes.draw do
  get "companies/index"
  get "industries/index"
  get "cities/index"
  get "jobs/index"
  devise_for :users
  root "static_pages#index"
  get "static_pages/index"
end
