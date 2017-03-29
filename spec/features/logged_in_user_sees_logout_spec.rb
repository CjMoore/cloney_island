require "rails_helper"

describe "when a user loggs in" do
  it "'login' turns into 'logout' on nav" do
    user = User.create(first_name: "Billy",
                last_name: "Goat",
                username: "billygoat",
                password: "pass",
                phone: "555-555-5555",
                email: "billygoat@gmail.com",
               )
    visit login_path

   fill_in "session[username]", with: "billygoat"
   fill_in "session[password]", with: "pass"
   within(".login-form") do
     click_on("Login")
   end

   expect(current_path).to eq(root_path)

  #  save_and_open_page
   within(".nav-wrapper") do
     expect(page).to have_content("Logout")
     expect(page).to_not have_content("Login")
   end
  end
end
