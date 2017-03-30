
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
   visit root_path
   within(".nav-wrapper") do
     click_on "Logout"
   end
save_and_open_page

   expect(current_path).to eq(login_path)

   within(".container") do
     expect(page).to have_content("You have successfully logged out")
   end

   within(".nav-wrapper") do
     expect(page).to have_content("Logout")
   end
 end
end
