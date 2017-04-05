require 'rails_helper'

describe "as an admin I can deactivate an user" do
  before(:each) do
    admin = create(:user, username: "admin")
    admin_user = create(:role, name: "admin_user", id: 4)
    admin.roles << admin_user
    @reg_user_1 = create(:user)
    reg_role = create(:role, name: "registered_user", id: 1)
    @reg_user_1.roles << reg_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "when I'm at the '/users' page I see a buttons with deactivate options" do

    visit users_path
    expect(page).to have_content("Users Info")
    expect(page).to have_button("Deactivate")
    expect(page).to have_button("Make Admin")
  end

  it "if deactivate button is selected, user becomes deactivated" do

    visit users_path

    table_rows = page.all('.users-table tr')

    within(table_rows[2]) do
      click_button("Deactivate")
    end

    expect(page).to have_button("Activate")

    within('.user-info') do
      within('.num-regs') do
        expect(page).to have_content(0)
      end
    end

    expect(@reg_user_1.roles.count).to eq(1)
  end
end
