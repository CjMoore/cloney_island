require "rails_helper"

describe "An reg user" do
 it "has a registered user role" do
   project = create(:project)
   reg_user = create(:user, username: "billygoat")
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

  it "guest cannot see users show page" do
    project = create(:project)

    visit "/projects/#{project.slug}/funds"

    expect(current_path).to eq(root_path)
  end
end
