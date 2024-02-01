class MovieFacade 

  def movies
    service = MovieService.new
    json = service.top_20_rated

    @movies = json[:results].take(20).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie_search(query)
    service = MovieService.new
    json = service.search_movies(query)

    @movies = json[:results].take(20).map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
