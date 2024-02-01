class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @search_params = params[:q]
    # require 'pry';binding.pry
    if params[:q] == 'top rated'
      @movies = MovieFacade.new.movies
    else
      @movies = MovieFacade.new.movie_search(params[:search_keywords])
    end
  end
end
