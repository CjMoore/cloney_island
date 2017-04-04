require "rails_helper"

describe "when user is logged in" do
  it "they are able to see a form to update their information" do
    user = create(:user)
    role = create(:role)
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}"

    click_on("Edit")

    expect(current_path).to eq("/#{user.slug}/edit")
    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Username")
    expect(page).to have_content("Email")
    expect(page).to have_content("Phone")
    expect(page).to have_content("Password")
    expect(page).to have_button("Update Account")
  end

  it "they are able to update all info with the exception of their password" do
    user = create(:user)
    role = create(:role)
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}"

    click_on("Edit")

    fill_in "user[first_name]", with: "Jefferey"
    fill_in "user[last_name]", with: "Lebowski"
    fill_in "user[username]", with: "TheDude"
    fill_in "user[avatar_url]", with: "http://www.velvetgeek.com/wp-content/themes/gallerific/image.php?width=570&image=http://www.velvetgeek.com/wp-content/uploads/2016/01/Dude.jpg"
    fill_in "user[email]", with: "dude@dude.com"
    fill_in "user[phone]", with: "555-555-5555"
    fill_in "user[password]", with: "password"

    click_on("Update Account")

    expect(current_path).to eq("/#{user.slug}")

    expect(page).to have_content("TheDude")
    expect(page).to have_content("Jefferey")
    expect(page).to have_content("Lebowski")
    expect(page).to have_content("dude@dude.com")
  end
end
