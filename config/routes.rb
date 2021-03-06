Rails.application.routes.draw do
  resources :users, only: [:index]
  post '/new', to: 'conversations#create'
  post '/signup', to: 'users#create'
  post '/login', to: 'auth#create'
  get '/home', to: 'auth#show'
  delete '/conversations', to: 'conversations#delete'
  # resources :messages, only: [:create]
  resources :conversations, only: [:index]
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
