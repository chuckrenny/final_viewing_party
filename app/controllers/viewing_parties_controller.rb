class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.movie_details(params[:movie_id])
  end

  def create

  end
end
