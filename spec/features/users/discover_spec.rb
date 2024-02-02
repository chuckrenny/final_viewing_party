require 'rails_helper'

# US 1
RSpec.describe 'Discover movies page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Sam', email: 'sam@email.com')

    visit user_discover_path(@user1)
  end

  it "shows the 'Discover Top Rated Movies' button" do
    expect(page).to have_link('Discover Top Rated Movies')
  end

  it 'has a text field to enter search keywords' do
    expect(page).to have_field('Search by Movie Title')
  end

  it 'shows a button to search by Movie Title' do
    expect(page).to have_button('Search')
  end
end
