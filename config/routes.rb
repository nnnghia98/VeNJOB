Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "static_pages#top_page"
  get "static_pages/top_page"
  get "static_pages/favorite"
  get "static_pages/history"
end
