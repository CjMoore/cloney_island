require 'rails_helper'

describe "a project owner can see their owned projects in dashboard" do
    before(:each) do
      @user = create(:user)
      registered_role = create(:role)
      project_owner = Role.create(name: "project_owner")
      @user.roles << registered_role
      @user.roles << project_owner

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

  it "has users personal details" do

    visit "/#{@user.slug}"
    expect(page).to have_content("#{@user.first_name}")
    expect(page).to have_content("#{@user.last_name}")
    expect(page).to have_content("#{@user.email}")
  end

  it "user can see a table with their owned projects" do

    visit "/#{@user.slug}"

    # save_and_open_page
  end
end


# They see a table with all of their owned projects
# The table includes project name
# Each project name is a link to the project show
# Total amount
# Total Funded
# Remaining Time
# There is a button labeled “Edit”
# There is a button labeled “Disable"
