require "rails_helper"

describe "when user wants to update their password" do
  xit "they have to provide an auth code sent by sms" do
    user = create(:user, phone: "2025313141")
    role = create(:role)
    user.roles << role

    visit root_path

    within(".nav-wrapper") do
      click_on("Login")
    end

    expect(current_path).to eq(login_path)

    fill_in "session[username]", with: "#{user.username}"
    fill_in "session[password]", with: "password"
    within(".login-form") do
      click_on("Login")
    end

    user.update_attribute(:token, "a1b2c3")

    visit "/#{user.slug}"

    click_on("Update Password")

    expect(page).to have_content("Current password")
    expect(page).to have_content("New password")
    expect(page).to have_content("Token")

    fill_in "user[password]", with: "password"
    fill_in "new_password", with: "pass"
    fill_in "token", with: "a1b2c3"

    click_on("Update Password")

    expect(current_path).to eq("/#{user.slug}")

    within(".nav-wrapper") do
      click_on("Logout")
    end

    fill_in "session[username]", with: "#{user.username}"
    fill_in "session[password]", with: "pass"
    within(".login-form") do
      click_on("Login")
    end

    expect(current_path).to eq(root_path)

    within(".nav-wrapper") do
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")
    end
  end

  xit "they cannot edit password without token" do
    user = create(:user, phone: "2025313141")
    role = create(:role)
    user.roles << role

    visit root_path

    within(".nav-wrapper") do
      click_on("Login")
    end

    expect(current_path).to eq(login_path)

    fill_in "session[username]", with: "#{user.username}"
    fill_in "session[password]", with: "password"
    within(".login-form") do
      click_on("Login")
    end

    user.update_attribute(:token, "a1b2c3")

    visit "/#{user.slug}"

    click_on("Update Password")

    expect(page).to have_content("Current password")
    expect(page).to have_content("New password")
    expect(page).to have_content("Token")

    fill_in "user[password]", with: "password"
    fill_in "new_password", with: "pass"
    fill_in "token", with: "1111"


    click_on("Update Password")

    expect(current_path).to eq("/#{user.slug}/update_password")
  end

  xit "they have to enter their correct password and be authroized" do
    user = create(:user, phone: "2025313141")
    role = create(:role)
    user.roles << role

    visit root_path

    within(".nav-wrapper") do
      click_on("Login")
    end

    expect(current_path).to eq(login_path)

    fill_in "session[username]", with: "#{user.username}"
    fill_in "session[password]", with: "password"
    within(".login-form") do
      click_on("Login")
    end

    user.update_attribute(:token, "a1b2c3")

    visit "/#{user.slug}"


    click_on("Update Password")

    expect(page).to have_content("Current password")
    expect(page).to have_content("New password")
    expect(page).to have_content("Token")

    fill_in "user[password]", with: "wrong password"
    fill_in "new_password", with: "pass"
    fill_in "token", with: "1111"


    click_on("Update Password")

    expect(current_path).to eq("/#{user.slug}/update_password")
  end

  it "a user without a token cannot update their password" do
    user = create(:user, phone: "2025313141")
    role = create(:role)
    user.roles << role

    visit root_path

    within(".nav-wrapper") do
      click_on("Login")
    end

    expect(current_path).to eq(login_path)

    fill_in "session[username]", with: "#{user.username}"
    fill_in "session[password]", with: "password"
    within(".login-form") do
      click_on("Login")
    end

    visit "/#{user.slug}"

    click_on("Update Password")

    expect(page).to have_content("I'm sorry, I can't let you do that")
  end
end
