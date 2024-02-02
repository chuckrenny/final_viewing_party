require 'rails_helper'

# US 4
RSpec.describe 'New Viewing Party', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Alice', email: 'alice@email.com')
    @user3 = User.create!(name: 'Bob', email: 'bob@email.com')
    
    #The Dark Knight is id: 155
    VCR.use_cassette('the_dark_knight_movie_show_page') do
      visit new_viewing_party_path(user_id: @user1, movie_id: '155')
    end
  end

  it 'displays the movie header' do
    save_and_open_page
    expect(page).to have_content('Create a Movie Party for The Dark Knight')
  end

  it 'expects page to have discover page button' do
    expect(page).to have_button('Discover Page')
  end

  describe "new viewing party form" do
    it "has a 'Duration of Party' field prefilled with the movie's runtime in minutes" do
      expect(page).to have_field(:duration_of_party, with: '152')
    end

    it "has date and time selection fields" do
      expect(page).to have_field("Day")
    end

    it "has individual checkboxes to invite every other existing user" do
      expect(page).to have_unchecked_field(@user2)
      expect(page).to have_unchecked_field(@user3)

      expect(page).to_not have_checked_field(@user1)
    end

    it "has a button to create a party" do
      expect(page).to have_button("Create Party").once
    end
  end

  describe "happy path" do
    it "redirects to the user's dashboard where the new event is shown", :vcr do
      check(@user2.formatted)
      fill_in :day, with: "12/01/2023"
      fill_in :start_time, with: "03:00 PM"

      click_button("Create Party")

      expect(current_path).to eq(user_path(@user1))

      visit user_path(@user2.id)
      expect(page).to have_content(@movie.title)
    end
  end
end
