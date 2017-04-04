require "rails_helper"

describe "when admin is logged in " do
  it "they can see a list of all users" do
    admin = create(:user)
    admin.roles << Role.create(name: "admin_user")

    reg_user = create(:role)
    user1 = create(:user)
    user1.roles << reg_user
    user2 = create(:user, username: "user2")
    user2.roles << reg_user

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit users_path

    within('.users-table') do
      expect(page).to have_content(user1.username)
      expect(page).to have_content(user2.username)
      expect(page).to have_button("Deactivate")
      expect(page).to have_button("Make Admin")
      expect(page).to have_content("registered user")
      expect(page).to have_content("admin user")
    end
  end
end
