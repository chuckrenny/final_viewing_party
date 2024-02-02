Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'welcome#index'
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get '/movies', to: 'movies#index', as: 'movies' #user_movies_path
  end

  get '/user/:user_id/discover', to: 'users#discover', as: 'user_discover'
  get '/user/:user_id/movies/:movie_id', to: 'movies#show', as: 'user_movie'
  get '/users/:user_id/movies/:movie_id/viewing_party/new', to: 'viewing_parties#new', as: 'new_viewing_party'
  post '/users/:user_id/movies/:movie_id/viewing_party', to: 'viewing_parties#create'
end
