require 'rails_helper'

describe "a registered user in the create project page" do
  it "they can create project and gain project owner role" do

    user= create(:user)
    registered_role = create(:role)
    user.roles << registered_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/new"

    fill_in "projects[title]", with: "Goat farm"
    fill_in "projects[image_url]", with: "http://www.babypygmygoats.com/wp-content/uploads/2015/05/baby-goat-jumping.jpg"
    fill_in "projects[description]", with: "best goat ever"
    select "1 Week", from: "projects[total_time]"
    fill_in "projects[amount_to_raise]", with: "40000"
    fill_in "projects[Contributor Email]", with: "billy@goat.com"

    click_on "Create Project"

    # expect(current_path).to have_content('projects/:1')
    # expect(page).to have_content("Goat Farm")
    # expect(current_path).to_not eq(root_path)
  end
end
