require 'rails_helper'

# US 3
RSpec.describe 'Movie Details Page' do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')

    visit user_discover_path(@user1)
    VCR.use_cassette("top_20_rated_movies") do
      click_link('Discover Top Rated Movies')
    end
  end

  it 'displays a button to create a viewing party' do
    VCR.use_cassette('the_dark_knight_movie_show_page', record: :new_episodes) do
      click_link('The Dark Knight')
      expect(page).to have_button('Create Viewing Party')
    end
  end

  it 'displays a button to return to Discover page' do
    VCR.use_cassette('the_dark_knight_movie_show_page') do
      click_link('The Dark Knight')
      expect(current_path).to eq(user_movie_path(@user1.id, movie_id: '155'))
      expect(page).to have_button('Discover Page')
    end
  end

  it 'displays the movie information' do
    VCR.use_cassette('the_dark_knight_movie_show_page', record: :new_episodes) do
      click_link('The Dark Knight')
      expect(current_path).to eq(user_movie_path(@user1.id, movie_id: '155'))
      expect(page).to have_content('The Dark Knight')
      expect(page).to have_content('Vote: 8.5')
      expect(page).to have_content('Runtime: 2hr 32mins')
      expect(page).to have_content('Genre: Drama, Action, Crime, Thriller')      
      expect(page).to have_content('Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.')
      expect(page).to have_content('Christian Bale as Bruce Wayne / Batman')
      expect(page).to have_content('Total Reviews: 13')
      expect(page).to have_content('tricksy: Excellent movie. Best of the trilogy. Lovely music. Nolan is a genius. So is Heath Ledger.')
    end
  end
end
