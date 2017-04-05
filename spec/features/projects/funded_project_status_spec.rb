require 'rails_helper'

describe "Funded Project" do
  it "shows projects over total funding" do
    user = create(:user)
    role = create(:role, name: "project_funder" )
    user.roles << role
    project  = create(:project)
    project2 = create(:project)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    UserFundedProject.create(project: project, user: user, amount: 10000000, credit_card_number: Faker::Business.credit_card_number)
    UserFundedProject.create(project: project2, user: user, amount: 2, credit_card_number: Faker::Business.credit_card_number)

    visit "/projects"

    funded = page.all(".card-content")

    within(funded[0]) do
      expect(page).to have_content("Funded!")
    end

    within(funded[1]) do
      expect(page).to_not have_content("Funded!")
    end
  end
end
