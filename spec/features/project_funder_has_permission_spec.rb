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
  it "to visit project index" do
    projects = create_list(:project, 3)

    visit projects_path
    expect(current_path).to eq(projects_path)
  end
  it "to visit project show" do
    project = create(:project)

    visit "/projects/#{project.slug}"

    expect(current_path).to eq("/projects/#{project.slug}")
  end
  it "to visit profile page" do
    visit root_path

    within(".nav-wrapper") do
      click_on("Profile")
    end

    expect(current_path).to eq("/#{@user.slug}")
  end
  it "can logout" do
    visit root_path

    within(".nav-wrapper") do
      click_on("Logout")
    end

    expect(current_path).to eq(root_path)
  end
  context "does not have permission to visit" do
    it "login page" do
      visit login_path

      expect(current_path).to_not eq(login_path)
      expect(current_path).to eq(root_path)
    end
    it "create user" do
      visit signup_path

      expect(current_path).to_not eq(signup_path)
      expect(current_path).to eq(root_path)
    end
  end
end
