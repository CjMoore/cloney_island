require 'rails_helper'

describe "a project owner can see their owned projects in dashboard" do
    before(:each) do
      @user = create(:user)
      registered_role = create(:role)
      project_1 = create(:project, name: "Guitars")
      project_2 = create(:project, name: "Tiki Bars")
      project_3 = create(:project, name: "Conch Fritters")
      project_4 = create(:project, name: "Turing Bootcamp")
      @user.owned_projects << project_1
      @user.owned_projects << project_2
      @user.owned_projects << project_3
      project_owner = Role.create(name: "project_owner")
      @user.roles << registered_role
      @user.roles << project_owner
      @user.roles << Role.create!(name: "project_funder")
      UserFundedProject.create(project: project_4, user: @user, amount: 4000, credit_card_number: Faker::Business.credit_card_number)


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


    within(".owned-projects") do
    expect(page).to have_content("Guitars")
    expect(page).to have_content("Tiki Bar")
    expect(page).to have_content("Conch Fritters")
    expect(page).to have_content("Project Name")
    expect(page).to have_content("Remaining Time")
    expect(page).to have_content("Total Amount Funded")
    expect(page).to have_content("Total Amount Needed")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Disable")
    end
  end
end
