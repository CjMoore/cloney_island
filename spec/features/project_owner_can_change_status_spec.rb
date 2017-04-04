require 'rails_helper'

describe "Project Owner" do
  it "can change status of project" do
    user = create(:user)
    user.roles << Role.create!(name: "project_owner")
    project = create(:project, status: 'active')
    user.owned_projects << project
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}"

    within("table#owned-table") do
      click_on "Disable"
    end

    expect(current_path).to eq "/#{user.slug}"
    within("table#owned-table") do
        expect(page).to have_button("Activate")
    end
    project.reload
    expect(project.active?).to be_falsy

    within("table#owned-table") do
      click_on "Activate"
    end
    project.reload
    expect(project.active?).to be_truthy
  end
end
