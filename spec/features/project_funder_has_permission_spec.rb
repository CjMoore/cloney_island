require 'rails_helper'

describe "project funder has permissions" do
  before(:each) do
    @user = create(:user)
    @role = Role.create(name: "project_funder")
    @user.roles << @role
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it "to visit root" do
    visit root_path
  end
  it "to visit create comment" do
    project = create(:project)

    visit "projects/#{project.slug}"

    fill_in "comment[content]", with: "This is a comment"
    click_on("Submit")
    expect(current_path).to eq("/projects/#{project.slug}")
  end
  it "to visit fund page" do
    project = create(:project)

    visit "projects/#{project.slug}"
    click_on("Fund")
    expect(current_path).to eq("/projects/#{project.id}/funds")
  end
end
