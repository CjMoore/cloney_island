require 'rails_helper'

describe "when guest completes create account form"
  scenario "an account is created and user sees dashboard" do

    visit '/users/new'

    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Doe"
    fill_in "Profile photo url", with: "https://s-media-cache-ak0.pinimg.com/originals/60/bd/d9/60bdd9ea7eaddc6d1aaadbe1132ad02e.jpg"
    fill_in "Email", with: "janedoe@example.com"
    fill_in "Cell phone number", with: "5558675309"
    fill_in "Username", with: "janedoe"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create account"

    expect(current_path).to eq('home#index')
  end
end
