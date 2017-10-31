require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in "Username:", :with => "tyler"
      fill_in "Password:", :with => "password"
      click_button "Sign Up"
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content "tyler"
    end
  end

  feature 'signing up with invalid parameters' do
    before(:each) do
      visit new_user_url
      fill_in "Username:", :with => "tyler"
      click_button "Sign Up"
    end

    scenario 're-render sign up page and show errors' do
      debugger
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login'

end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end
