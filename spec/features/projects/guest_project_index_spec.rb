require 'rails_helper'

describe "Guest" do
  it "goes to project index page" do
    projects = create_list(:project, 10)

    visit '/projects'

    expect(page).to have_content('Projects')
    expect(page).to have_content(projects.first.name)
    expect(page).to have_content(projects.first.description)
  end
end
