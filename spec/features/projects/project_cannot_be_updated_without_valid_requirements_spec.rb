require 'rails_helper'

describe "as a project cannot be edited when invalid information is given or missing" do
  before(:each) do
    @user = create(:user, username: "owner")
    registered = create(:role)
    @user.roles << registered
    @other_user = create(:user, first_name: "Other", email: "otheruser@example.com")
    @project = create(:project)
    @project_owner = create(:role, name: "project_owner")
    @user.roles << @project_owner
    @user.owned_projects << @project
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "cannot be updated with invalid parameters - collaborator email field blank" do

    visit "/projects/#{@project.slug}/edit"

    expect(current_path).to eq(project_edit_path(@project.slug))

    fill_in "project[name]", with: "Summer concerts"
    fill_in "project[image_url]", with: "https://c2.staticflickr.com/8/7007/6807427655_ff6d9d7ee7_z.jpg"
    fill_in "project[description]", with: nil

    click_on("Update Project")

    expect(page).to have_content("Please enter valid information to update the project.")
  end

  it "cannot be updated with invalid contributor email" do

    visit "/projects/#{@project.slug}/edit"

    expect(current_path).to eq(project_edit_path(@project.slug))

    fill_in "project[name]", with: "Summer concerts"
    fill_in "project[image_url]", with: "https://c2.staticflickr.com/8/7007/6807427655_ff6d9d7ee7_z.jpg"
    fill_in "project[description]", with: "Tequila!"
    fill_in "contributor_email", with: "anotheruser@example.com"

    click_on("Update Project")

    expect(page).to have_content("The email doesn't exit in our database. Please remove the email or enter a valid email address.")
  end

  it "can be updated with valid contributor email" do

    visit "/projects/#{@project.slug}/edit"

    expect(current_path).to eq(project_edit_path(@project.slug))

    fill_in "project[name]", with: "Summer concerts"
    fill_in "project[image_url]", with: "https://c2.staticflickr.com/8/7007/6807427655_ff6d9d7ee7_z.jpg"
    fill_in "project[description]", with: "Tequila!"
    fill_in "contributor_email", with: "otheruser@example.com"

    click_on("Update Project")

    expect(page).to have_content("Your project has been updated.")
  end

  it "cannot be updated with invalid input - with valid contributor email" do

    visit "/projects/#{@project.slug}/edit"

    expect(current_path).to eq(project_edit_path(@project.slug))

    fill_in "project[name]", with: "Summer concerts"
    fill_in "project[image_url]", with: "https://c2.staticflickr.com/8/7007/6807427655_ff6d9d7ee7_z.jpg"
    fill_in "project[description]", with: ""
    fill_in "contributor_email", with: "otheruser@example.com"

    click_on("Update Project")

    expect(page).to have_content("Your project was not updated, please enter valid project information.")
  end

end
