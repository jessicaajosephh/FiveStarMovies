Rails.application.routes.draw do
  root "sessions#home"

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'

  delete '/movies' => 'reviews#show'

  get '/auth/:provider/callback', to: 'sessions#omniauth'

  resources :genres, only: [:index, :show]
  resources :reviews
  resources :users do 
    resources :movies, only: [:new, :create, :index]
  end
  resources :movies do
    resources :reviews
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
