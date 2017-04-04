require 'rails_helper'

describe "as a project owner when editing a project without a collaborator" do
  before(:each) do
    @user = create(:user, username: "projowner")
    registered = create(:role)
    @user.roles << registered
    @project = create(:project, name: "Trippin")
    @user.owned_projects << @project
    @user.roles << create(:role, name: "project_owner")
    @other_user = create(:user, first_name: "Other", email: "otheruser@example.com")
    @other_user.roles << registered
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "I can add a collaborator that exists in the database" do

    visit "/projects/#{@project.slug}/edit"

    fill_in "project[name]", with: "Jamaica"
    fill_in "project[image_url]", with: "https://jamaicainn.com/images/Jamaica-inn-beach.jpg"
    fill_in "project[description]", with: "G's need a break of a lifetime"
    fill_in "contributor_email", with: "otheruser@example.com"

    click_on "Update Project"

    expect(page).to have_content("Jamaica")
    expect(page).to_not have_content("Trippin")
    expect(current_path).to eq("/projects/jamaica")
    expect(@project.owners.count).to eq(2)
  end

  it "I cannot add a collaborator that doesn't exist in the database" do

    visit "/projects/#{@project.slug}/edit"

    fill_in "project[name]", with: "Jamaica"
    fill_in "project[image_url]", with: "https://jamaicainn.com/images/Jamaica-inn-beach.jpg"
    fill_in "project[description]", with: "G's need a break of a lifetime"
    fill_in "contributor_email", with: "beyonce@example.com"

    click_on "Update Project"

    expect(page).to_not have_content("Jamaica")
    expect(page).to have_content("The email doesn't exit in our database. Please remove the email or enter a valid email address.")
    expect(@project.owners.count).to eq(1)
    expect(current_path).to eq(project_edit_path(@project.slug))
  end
end
