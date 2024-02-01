class Movie
  attr_reader :title, :rating

  def initialize(data)
    @title = data[:original_title]
    @rating = data[:vote_average]
  end
end
