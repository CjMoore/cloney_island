require 'rails_helper'

describe "as a project owner when creating a project" do
  before(:each) do
    @user = create(:user, username: "projowner")
    registered = create(:role)
    @user.roles << registered
    @other_user = create(:user, first_name: "Other", email: "otheruser@example.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can create a project without a contributor" do
    visit "/projects/new"

    fill_in "project[name]", with: "Jamaica"
    fill_in "project[image_url]", with: "https://jamaicainn.com/images/Jamaica-inn-beach.jpg"
    fill_in "project[description]", with: "G's need a break of a lifetime"
    select "3 Months", from: "time[month]"
    fill_in "project[total]", with: "5000"

    click_on "Create Project"

    expect(current_path).to eq("/#{@user.slug}")
    expect(page).to have_content("You just created a project without a contributor!")
  end

  it "can add a collaborator if they already exist in the database" do

    visit "/projects/new"

    fill_in "project[name]", with: "Jamaica"
    fill_in "project[image_url]", with: "https://jamaicainn.com/images/Jamaica-inn-beach.jpg"
    fill_in "project[description]", with: "G's need a break of a lifetime"
    select "3 Months", from: "time[month]"
    fill_in "project[total]", with: "5000"
    fill_in "contributor_email", with: "otheruser@example.com"

    click_on "Create Project"

    expect(current_path).to eq("/#{@user.slug}")
    expect(page).to have_content("A project was created with Other as a joint owner.")
  end

  it "cannot add a collaborator that is not already a user and project won't be created, flash message is rendered" do

    visit "/projects/new"

    fill_in "project[name]", with: "Jamaica"
    fill_in "project[image_url]", with: "https://jamaicainn.com/images/Jamaica-inn-beach.jpg"
    fill_in "project[description]", with: "G's need a break of a lifetime"
    select "3 Months", from: "time[month]"
    fill_in "project[total]", with: "5000"
    fill_in "contributor_email", with: "beyonce@example.com"

    click_on "Create Project"

    expect(current_path).to eq(new_project_path)
    expect(page).to have_content("The email doesn't exit in our database.")
  end

end
