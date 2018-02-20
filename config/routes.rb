Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'teams#index'
  get '/:slug', to: 'teams#show'
  resources :teams, only: [:create, :destroy]
  resources :channels, only: [:show, :create, :destroy, :update]
  resources :talks, only: [:show, :update]
  resources :team_users, only: [:create, :destroy]
  resources :invitations, only: [:create, :update, :index, :destroy]
  devise_for :users, :controllers => { registrations: 'registrations' }
end