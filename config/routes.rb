Rails.application.routes.draw do
  get "companies/index"
  get "companies/import"
  resources :companies do
    collection {post :import}
  end
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
  root "static_pages#top_page"
  get "static_pages/top_page"
  get "/favorite", to: "static_pages#favorite"
  get "/history",to: "static_pages#history"
end
