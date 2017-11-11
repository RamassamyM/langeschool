Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'home', to: 'pages#home'
  get 'parentscouncil', to: 'pages#parentscouncil'
  get 'schoolcouncil', to: 'pages#schoolcouncil'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
