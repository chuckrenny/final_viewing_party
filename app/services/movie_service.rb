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
    get_url("/3/movie/top_rated?language=en-US&page=1")
  end

  def search_movies(query)
    get_url("/3/search/movie?query=#{query}&include_adult=false&language=en-US&page=1")
  end
end
