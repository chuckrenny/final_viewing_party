class Movie
  attr_reader :id, :title, :rating, :runtime, :genres, :summary, :cast

  def initialize(data)
    # require 'pry';binding.pry
    @id = data[:id]
    @title = data[:original_title]
    @rating = data[:vote_average].round(1)
    @runtime = format_runtime(data[:runtime].to_i)
    @genres = format_genres(data[:genres])
    @summary = data[:overview]
    @cast = data[:cast]
  end

private
  def format_runtime(runtime)
    hours = (runtime / 60).floor
    minutes = runtime % 60
    "#{hours}hr #{minutes}mins"
  end

  def format_genres(genres)
    genres.present? ? genres.map { |genre| genre[:name]}.join(", ") : []
  end
end
