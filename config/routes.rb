Rails.application.routes.draw do
  namespace :users do 
    resources :searches, only: :index, defaults: { format: :json }
  end
  get 'static_pages/home'
  get 'static_pages/about'
  root to: 'static_pages#home'
  get 'login', to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  get 'mymap', to: 'users#mymap'
  get 'feed', to: 'inquiries#feed'
  resources :users
  resources :spots
  resources :memories
  resources :inquiries, only: [:index, :new, :create, :destroy]
end
