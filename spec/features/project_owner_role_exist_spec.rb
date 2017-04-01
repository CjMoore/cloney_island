require 'rails_helper'

describe "a registered user in the create project page" do
  it "they can create project and gain project owner role" do

    user= create(:user)
    registered_role = create(:role)
    user.roles << registered_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/new"

    fill_in "projects[name]", with: "Puppy Store"
    fill_in "projects[image_url]", with: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwipx5y7vYLTAhVD6mMKHfWqDYcQjRwIBw&url=http%3A%2F%2Fwww.pups-pals.com%2Fpuppy-kindergarten.html&psig=AFQjCNHf_ulNe6wevWaJNJWTKHXFKuNzPA&ust=1491109361985107"
    fill_in "projects[description]", with: "Cute pup"
    select "3 Months", from: "time[month]"
    fill_in "projects[total]", with: "5000"
    fill_in "projects[contributor_email]", with: "edilene@example.com"

    expect(page).to have_content("Title")
    expect(page).to have_content("Image url")
    expect(page).to have_content("Description")
    expect(page).to have_content("Total")
    expect(page).to have_content("Amount to raise")
    expect(page).to have_content("Contributor email")

    save_and_open_page

    click_on "Create Project"

    expect(current_path).to eq(user_owned_projects_path(user))
  end
end
