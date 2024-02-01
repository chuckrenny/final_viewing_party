class SearchController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = SearchFacade.new(params[:state])
  end
end
