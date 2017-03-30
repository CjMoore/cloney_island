require 'rails_helper'

describe "a guest in the login page" do
  scenario "they see link to create account" do

      visit '/login'
      click_on "Create Account"

      expect(page).to have_content("First name")
      expect(page).to have_content("Last name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Phone")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password confirmation")
  end
end
