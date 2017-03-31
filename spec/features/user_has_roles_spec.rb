require "rails_helper"

describe "An user" do
 it "has a registered user role" do
   user = create(:user)
   role = Role.create(name: "registered_user")
   user.roles << role
   visit login_path

   fill_in "session[username]", with: "billygoat"
   fill_in "session[password]", with: "pass"

   within(".login-form") do
    click_on("Login")
   end
   expect(user.roles[0].name).to eq("registered_user")
  end
 end
