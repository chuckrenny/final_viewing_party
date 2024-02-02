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

  def show
    # require 'pry';binding.pry
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.movie_details(params[:movie_id])
    @cast = MovieFacade.new.cast(params[:movie_id])
    @reviews = MovieFacade.new.reviews(params[:movie_id])
  end
end
