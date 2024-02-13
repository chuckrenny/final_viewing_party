require 'rails_helper'

RSpec.describe 'User Login' do
  describe 'happy path' do
    # As a visitor
    # When I visit `/register`
    # I see a form to fill in my name, email, password, and password confirmation.
    # When I fill in that form with my name, email, and matching passwords,
    # I'm taken to my dashboard page `/users/:id`
    it 'allows a user to register' do
      name = 'Test Name'
      email = 'test@email.com'
      password = 'test'

      visit register_user_path

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create New User'

      expect(current_path).to eq(user_path(User.all.last))
    end

    # As a registered user
    # When I visit the landing page `/`
    # I see a link for "Log In"
    # When I click on "Log In"
    # I'm taken to a Log In page ('/login') where I can input my unique email and password.
    # When I enter my unique email and correct password 
    # I'm taken to my dashboard page
    it 'allows a registered user to log in' do
      user = User.create!(name: "funbucket13", email: 'test@gmail.com', password: "test", password_confirmation: "test")

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"

      expect(current_path).to eq(user_path(User.all.last))

      expect(page).to have_content("Welcome, #{user.name}")
    end
  end

  describe 'sad path' do
    # As a visitor
    # When I visit `/register`
    # and I fail to fill in my name, unique email, OR matching passwords,
    # I'm taken back to the `/register` page
    # and a flash message pops up, telling me what went wrong
    it 'fails if passwords do not match' do
      name = 'Test Name'
      email = 'test@email.com'

      visit register_user_path

      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in :user_password, with: 'test'
      fill_in :user_password_confirmation, with: ''

      click_on 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Password confirmation doesn't match")
    end

    # As a registered user
    # When I visit the landing page `/`
    # And click on the link to go to my dashboard
    # And fail to fill in my correct credentials 
    # I'm taken back to the Log In page
    # And I can see a flash message telling me that I entered incorrect credentials.
    it 'returns to the log in page if incorrect credentials are filled for user show' do
      visit register_user_path
      fill_in :user_name, with: 'Test1'
      fill_in :user_email, with: 'test@email.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_on 'Create New User'

      visit root_path

      click_on('Log In')

      fill_in :email, with: 'test@email.com'
      fill_in :password, with: 'wrong_password'
      click_on('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are bad')
    end
  end
end
