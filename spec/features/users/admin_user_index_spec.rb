require "rails_helper"

describe "when admin is logged in " do
  it "they can see a list of all users" do
    reg_user = create(:role, id: 1)
    proj_owner = create(:role, name: "project_owner", id: 2)
    proj_funder = create(:role, name: "project_funder", id: 3)
    admin_user = create(:role, name: "admin_user", id: 4)
    admin = create(:user)
    admin.roles << admin_user

    user1 = create(:user)
    user1.roles << reg_user
    user2 = create(:user, username: "user2")
    user2.roles << reg_user << proj_owner

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit users_path

    within('.nav-wrapper') do
      expect(page).to have_content("User Index")
    end

    within('.users-table') do
      expect(page).to have_content(user1.username)
      expect(page).to have_content(user2.username)
      expect(page).to have_button("Deactivate")
      expect(page).to have_button("Make Admin")
      expect(page).to have_content("registered user")
      expect(page).to have_content("admin user")
    end

    within('.user-info') do
      expect(page).to have_content(2)
      expect(page).to have_content(1)
      expect(page).to have_content("Registered Users")
      expect(page).to have_content("Project Owners")
      expect(page).to have_content("Project Funders")
      expect(page).to have_content("Admins")
    end
  end
end
