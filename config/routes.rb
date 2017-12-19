Rails.application.routes.draw do
  get 'team_users/create'

  get 'team_users/destroy'

  get 'talks/show'

  get 'channels/create'

  get 'channels/destroy'

  get 'channels/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'teams#index'
  resources :teams, only: [:create, :destroy]
  get '/:slug', to: 'teams#show'
  
end
