class MovieService
  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = Rails.application.credentials.TMDB[:Authorization]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_20_rated
    get_url("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=200&with_original_language=en&without_genres=99%2C10755")
  end

  def search_movies(query)
    get_url("/3/search/movie?query=#{query}&include_adult=false&language=en-US&page=1")
  end
end
