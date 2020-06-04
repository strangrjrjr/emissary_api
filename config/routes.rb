Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  get '/home', to: 'auth#show'
  
  resources :messages, only: [:create]
  resources :conversations, only: [:index, :create, :delete]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
