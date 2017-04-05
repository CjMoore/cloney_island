require 'rails_helper'

describe "ApplicationHelper" do
  describe "admin_user?" do
    before(:each) do
      @admin = create(:user, username: "admin", password: "password")
      project = create(:project)
      project.owners << @admin
      @admin.roles << Role.create!(id: 1, name: "registered_user")
      @admin.roles << Role.create!(id: 2, name: "project_owner")
      @admin.roles << Role.create!(id: 3, name: "project_funder")
      @admin.roles << Role.create!(id: 4, name: "admin_user")
    end

    it "can login and confirms roles" do

      visit login_path

      fill_in "session[username]", with: "admin"
      fill_in "session[password]", with: "password"

      within(".login-form") do
        click_on("Login")
      end
      expect(current_path).to eq(root_path)

      within('.nav-wrapper') do
        expect(page).to have_content("User Index")
      end

      within('.nav-wrapper') do
        click_on "User Index"
      end

      expect(current_path).to eq(users_path)

      within('.nav-wrapper') do
        click_on "Profile"
      end
      expect(current_path).to eq(username_path(@admin.slug))
    end
  end
end
