require 'rails_helper'

describe "deactivated user cannot login" do
  it "deactivated user sees message notifying that they are banned" do

    banned_user = create(:user, username: "billy", password: "password")
    banned_roles = Role.create(id: 5, name: "deactivated_user")
    banned_user.roles << banned_roles

    visit login_path

    fill_in "session[username]", with: "billy"
    fill_in "session[password]", with: "password"

    within(".login-form") do
      click_on("Login")
    end

    expect(page).to have_content("You have been banned from Crowdfunder!")
  end
end
