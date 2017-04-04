require 'rails_helper'

describe "Registered User" do
  it "sees profile page" do
    reg_user = create(:user)
    reg_user.roles << Role.create!(name: "registered_user")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(reg_user)

    visit '/'

    within (".nav-wrapper") do
      click_on "Profile"
    end

    expect(current_path).to eq "/#{reg_user.slug}"

    expect(page).to have_content(reg_user.email)
    expect(page).to have_content(reg_user.username)
    expect(page).to have_content("Edit")
  end
end
