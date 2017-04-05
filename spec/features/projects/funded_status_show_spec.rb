require 'rails_helper'

describe "Funded Project" do
  it "shows funded on project show" do
    user = create(:user)
    role = create(:role, name: "project_funder" )
    user.roles << role
    project  = create(:project, status: "funded")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    UserFundedProject.create(project: project, user: user, amount: 10000000, credit_card_number: Faker::Business.credit_card_number)

    visit "/projects/#{project.slug}"

    funded = page.all("#welcome")

    within(funded[0]) do
      expect(page).to have_content("Funded!")
    end
    expect(project.status).to eq "funded"
  end
end
