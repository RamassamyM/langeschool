Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'
  get 'home', to: 'pages#home'
  get 'codeinput', to: 'pages#codeinput'
  get 'parentscouncil', to: 'pages#parentscouncil'
  get 'subscribe', to: 'pages#subscribe'
  get 'schoolcouncil', to: 'pages#schoolcouncil'
  get 'legalterms', to: 'pages#legalterms'
  get 'subscribe_form', to: 'pages#subscribe_form'
  resources :posts
  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  get '/conversation/new/:id', to: 'conversations#new', as: 'new_conversation'
  resources :messages, only: [:show]
  resources :notifications, only: [:index]
  resources :classrooms, only: [:index]

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
