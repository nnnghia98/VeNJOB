Rails.application.routes.draw do
  get "companies/index"
  resources :companies do
    collection {post :import}
  end
  get "industries/index"
  resources :industries do
    collection {post :import}
  end
  get "cities/index"
  resources :cities do
    collection {post :import}
  end
  get "jobs/index"
  resources :jobs do
    collection {post :import}
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "static_pages#index"
  get "static_pages/index"
end
