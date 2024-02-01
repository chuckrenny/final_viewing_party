class Movie
  attr_reader :title, :rating

  def initialize(data)
    require 'pry';binding.pry
    @title = data[:title]
    @rating = data[:rating]
  end
end
