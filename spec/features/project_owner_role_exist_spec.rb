require 'rails_helper'

describe "a registered user in the create project page" do
  it "they can create project and gain project owner role" do

    user = create(:user)
    contributor = create(:user, username: "geegee", email: "edilene-cruz@hotmail.com")
    registered_role = create(:role)
    user.roles << registered_role
    contributor.roles << registered_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/new"

    fill_in "project[name]", with: "Puppy Store"
    fill_in "project[image_url]", with: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwipx5y7vYLTAhVD6mMKHfWqDYcQjRwIBw&url=http%3A%2F%2Fwww.pups-pals.com%2Fpuppy-kindergarten.html&psig=AFQjCNHf_ulNe6wevWaJNJWTKHXFKuNzPA&ust=1491109361985107"
    fill_in "project[description]", with: "Cute pup"
    select "3 Months", from: "time[month]"
    fill_in "project[total]", with: "5000"
    fill_in "contributor_email", with: "edilene-cruz@hotmail.com"

    expect(page).to have_content("Title")
    expect(page).to have_content("Image url")
    expect(page).to have_content("Description")
    expect(page).to have_content("Total")
    expect(page).to have_content("Amount to raise")
    expect(page).to have_content("Contributor email")


    click_on "Create Project"

    expect(current_path).to eq(username_path(user.username))
    expect(user.roles.count).to eq(2)
    expect(user.roles.first.name).to eq("registered_user")
    expect(user.roles.last.name).to eq("project_owner")
    expect(contributor.roles.count).to eq(2)
    expect(contributor.roles.first.name).to eq("registered_user")
    expect(contributor.roles.last.name).to eq("project_owner")
  end
end
