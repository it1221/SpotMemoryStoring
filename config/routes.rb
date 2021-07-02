Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/about'
  root to: 'static_pages#home'
  get 'login', to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  get 'mymap', to: 'users#mymap'
  resources :users
  resources :spots
  resources :memories
end
