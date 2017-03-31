require "rails_helper"

describe "when logged in user is on project show" do
  it "they can submit a comment" do
    user = create(:user, username: "billygoat", password:"pass")
    role = Role.create(name: "registered_user")
    user.roles << role
    visit login_path

   fill_in "session[username]", with: "billygoat"
   fill_in "session[password]", with: "pass"

   within(".login-form") do
     click_on("Login")
   end

   within(".nav-wrapper") do
     expect(page).to have_content("Logout")
   end

    project = create(:project)

    visit("/projects/#{project.slug}")

    expect(page).to_not have_link("Register/Sign in to fund")
    expect(page).to have_link("Fund")
    save_and_open_page
    fill_in "comment[content]", with: "this is a comment"
    click_on "Submit Comment"

    expect(page).to have_content("this is a comment")
  end
end
