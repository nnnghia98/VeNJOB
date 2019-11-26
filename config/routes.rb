Rails.application.routes.draw do
  root "static_pages#top_page"
  get "static_pages/top_page"
  get "static_pages/favorite"
  get "static_pages/history"
end
