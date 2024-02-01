require 'rails_helper'

RSpec.describe 'Movie Results Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Sam', email: 'sam@email.com')

    visit user_discover_path(@user2)
    click_button('Discover Top Rated Movies')
  end

  # When I visit the discover movies page ('/users/:id/discover'),
  # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
  # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 

  # - Title (As a Link to the Movie Details page (see story #3))
  # - Vote Average of the movie

  # I should also see a button to return to the Discover Page.
  # Notes:

  # There should only be a maximum of 20 results. The above details should be listed for each movie.
  it 'displays a button to return to discover page' do
    expect(current_path).to eq(user_movies_path(@user2))
    click_button('Discover Page')
    expect(current_path).to eq(user_discover_path(@user2))
  end

  it 'displays the top 20 movies when clicking Discover Top Rated Movies button' do
    expect(current_path).to be(user_movies_path(@user2))
    expect(page).to have_content('Viewing Party: Top 20 Movies')

    
  end
end
