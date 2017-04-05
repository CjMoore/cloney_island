require 'rails_helper'

describe "Guest" do
  it "goes to project index page" do
    user = create(:user)
    role = create(:role, name: "project_funder" )
    user.roles << role
    project = create(:project)
    project2 = create(:project)
    project3 = create(:project)
    project4 = create(:project)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    UserFundedProject.create(project: project, user: user, amount: 1000000, credit_card_number: Faker::Business.credit_card_number)
    UserFundedProject.create(project: project2, user: user, amount: 2, credit_card_number: Faker::Business.credit_card_number)
    UserFundedProject.create(project: project3, user: user, amount: 3, credit_card_number: Faker::Business.credit_card_number)
    UserFundedProject.create(project: project4, user: user, amount: 4, credit_card_number: Faker::Business.credit_card_number)

    visit root_path
    expect(page).to have_content(project2.name)
    expect(page).to have_content(project3.name)
    expect(page).to have_content(project4.name)
    expect(page).to_not have_content(project.name)
  end
end
