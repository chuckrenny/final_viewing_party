require 'rails_helper' # rubocop:disable Style/FrozenStringLiteralComment

RSpec.describe 'Movie Results Page', type: :feature do # rubocop:disable Metrics/BlockLength
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Sam', email: 'sam@email.com')

    visit user_discover_path(@user2)
  end

  it 'displays a button to return to discover page' do
    VCR.use_cassette('top_20_rated_movies') do
      click_link('Discover Top Rated Movies')
      expect(current_path).to eq(user_movies_path(@user2))
      expect(page).to have_content('Top 20 Movies')
      click_button('Discover Page')
      expect(current_path).to eq(user_discover_path(@user2))
    end
  end

  it 'displays the top 20 movies when clicking Discover Top Rated Movies button' do
    VCR.use_cassette("top_20_rated_movies") do # rubocop:disable Style/StringLiterals
      click_link('Discover Top Rated Movies')
      expect(current_path).to eq(user_movies_path(@user2))
      expect(page).to have_content("The Shawshank Redemption") # rubocop:disable Style/StringLiterals
    end
  end

  it 'displays the search results when searching by movie title' do
    VCR.use_cassette("search_results_for_The_Batman_Movie", record: :new_episodes) do # rubocop:disable Style/StringLiterals
      fill_in :search_keywords, with: 'The Batman'
      click_button('Search')
      expect(current_path).to eq(user_movies_path(@user2))
      expect(page).to have_content('Movie Search')
      expect(page).to have_content('The Batman')
      expect(page).to have_content('Rating: 7.7')
    end
  end
end
