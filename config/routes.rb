Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'teams#index'
  resources :teams, only: [:create, :destroy]
  get '/:slug', to: 'teams#show'
  
end
