require 'rails_helper'

describe "a project funder on the project page" do
  it "can see how much they have funded that project" do

    user = create(:user)
    registered_role = create(:role)
    user.roles << registered_role
    project = create(:project)
    user.user_funded_projects.create(amount: 4000, credit_card_number: "12341234", project_id: project.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/#{project.slug}"

    expect(page).to have_content($4,000)

  end
end
