require "rails_helper"

describe "when logged in user is on project show" do
  it "they click on the fund button and see a form" do
    project = create(:project)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/#{project.slug}"

    click_on("Fund")

    expect(page).to have_content("Amount")
    expect(page).to have_content("Credit Card Number")
  end
end
