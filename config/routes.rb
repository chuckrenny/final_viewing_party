Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'welcome#index'
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get '/movies', to: 'movies#index', as: 'movies' #user_movies_path
  end

  get '/user/:id/discover', to: 'users#discover', as: 'user_discover'
end
