class Movie
  attr_reader :title, :rating, :language

  def initialize(data)
    @title = data[:original_title]
    @rating = data[:vote_average]
    @language = data[:original_language]
  end
end
