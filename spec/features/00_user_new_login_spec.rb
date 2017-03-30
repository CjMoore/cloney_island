
require "rails_helper"

describe "when guest visits '/'" do
 it "they see a navbar with a logo and a link to login" do
   visit root_path

   within(".nav-wrapper") do
     click_on "Login"
   end
   expect(current_path).to eq(login_path)
 end

 it " when they click on login they see a form to login" do
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
 end
end
