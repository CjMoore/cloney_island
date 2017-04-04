require 'rails_helper'

describe "a registered user in the project page" do
  it "can fund project, gain project funder role" do

    user = create(:user)
    registered_role = create(:role)
    binding.pry
    user.roles << registered_role
    project = create(:project)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/#{project.slug}"

    click_on "Fund"

    expect(current_path).to eq("/projects/#{project.id}/funds")

    fill_in "user_funded_project[amount]", with: 4000
    fill_in "user_funded_project[credit_card_number]", with: "123412342341234"

    click_on "Fund"

    expect(current_path).to eq("/projects/#{project.slug}")
    expect(user.roles.count).to eq(2)
    expect(user.roles.first.name).to eq("registered_user")
    expect(user.roles.last.name).to eq("project_funder")
  end
end
