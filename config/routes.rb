Rails.application.routes.draw do
  devise_for :users

  resources :registered_applications
  
  get "welcome/index"
  get "welcome/about"

  root to: 'welcome#index'
  
  namespace :api, defaults: { format: :json } do
  	match 'create_event', to: 'events#create', via: [:options]
  	resources :events, only: [:create]
  end
end
