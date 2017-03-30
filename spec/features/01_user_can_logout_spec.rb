
require "rails_helper"

describe "when user" do
 it "clicks to logout" do
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
  
   visit root_path
   within(".nav-wrapper") do
     click_on "Logout"
   end

   expect(current_path).to eq(login_path)

   within(".notice") do
     expect(page).to have_content("You have successfully logged out")
   end

   within(".nav-wrapper") do
     expect(page).to have_content("Login")
   end
 end
end
