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

    # array
    @movies = json[:results].take(20).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie_details(movie)
    service = MovieService.new
    json = service.movie_details(movie)

    # hash
    Movie.new(json)
  end

  def cast(movie)
    service = MovieService.new
    json = service.movie_cast(movie)

    json[:cast].take(10)
  end

  def reviews(movie)
    service = MovieService.new
    json = service.reviews(movie)

    json[:results]
  end
end
