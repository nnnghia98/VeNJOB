Rails.application.routes.draw do
  get 'companies/index'
  get 'companies/import'
  get "industries/index"
  get "industries/import"
  resources :industries do
    collection {post :import}
  end
  get "cities/index"
  get "cities/import"
  resources :cities do
    collection {post :import}
  end
  get "jobs/index"
  get "jobs/import"
  resources :jobs do
    collection {post :import}
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "static_pages#index"
  get "static_pages/index"
end
