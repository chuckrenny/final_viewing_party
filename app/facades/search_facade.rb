class SearchFacade 
  def initialize(state)
    @state = state
  end

  def members
    service = MovieService.new
    json = service.top_20_rated(@state)

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
