require "rails_helper"

describe "An reg user" do
 it "has a registered user role" do
   reg_user = create(:user, username: "billygoat")
   guest = create(:user)
   role = Role.create(name: "registered_user")
   reg_user.roles << role
   visit login_path

   fill_in "session[username]", with: "billygoat"
   fill_in "session[password]", with: "pass"

   within(".login-form") do
    click_on("Login")
   end
   expect(reg_user.roles[0].name).to eq("registered_user")

  end

  xit "guest cannot see users show page" do

    visit "/:project_id/fund"

    expect(current_path).to eq(login_path)
  end
end
