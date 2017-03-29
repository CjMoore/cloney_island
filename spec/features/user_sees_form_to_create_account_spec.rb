require 'rails_helper'

describe "a guest in the login page" do
  scenario "they see link to create account" do

    visit '/login'

    click_link "Create account"

    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Cell phone number")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    expect(page).to have_link("Create an account")
  end
end
