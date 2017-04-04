require "rails_helper"

describe "when addmin is on user index" do
  it "they can click admin next to a user and make that user an admin" do
    reg_user = create(:role, id: 1)
    proj_owner = create(:role, name: "project_owner", id: 2)
    proj_funder = create(:role, name: "project_funder", id: 3)
    admin_user = create(:role, name: "admin_user", id: 4)
    admin = create(:user)
    admin.roles << admin_user

    user1 = create(:user, username: "givemethepower")
    user1.roles << reg_user

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit users_path

    table_rows = page.all('.users-table tr')

    within(table_rows[2]) do
      click_on('Make Admin')
    end

    within('.user-info') do
      within('.num-admins') do
        expect(page).to have_content(2)
      end
    end

    within('.users-table') do
      expect(page).to_not have_button("Make Admin")
    end
  end
end
