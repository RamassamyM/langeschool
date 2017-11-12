Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'home', to: 'pages#home'
  get 'parentscouncil', to: 'pages#parentscouncil'
  get 'subscribe', to: 'pages#subscribe'
  get 'schoolcouncil', to: 'pages#schoolcouncil'
  get 'legalterms', to: 'pages#legalterms'
  get 'subscribe_form', to: 'pages#subscribe_form'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
