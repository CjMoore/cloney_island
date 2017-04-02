require 'rails_helper'

describe "Registered User/Project Funder" do
  it "can see funded projects table" do
    user = create(:user)
    user.roles << Role.create!(name: "project_funder")

    project = create(:project)
    UserFundedProject.create(project: project, user: user, amount: 4000, credit_card_number: Faker::Business.credit_card_number)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}"

    expect(current_path).to eq("/#{user.slug}")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Project Name")
    expect(page).to have_content("Remaining Time")
    expect(page).to have_content("Total Amount Funded")
    expect(page).to have_content("Total Needed")
    expect(page).to have_content("Amount I've Funded")
    expect(page).to have_content(user.funded_projects.name)
    expect(page).to have_content(user.funded_projects.first.total)
    expect(page).to have_content("$4,000.00")
  end
end
