require "rails_helper"

describe "when logged in user is on project show" do
  it "they can submit a comment" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    project = create(:project)

    visit("/projects/#{project.slug}")

    expect(page).to_not have_link("Register/Sign in to fund")
    expect(page).to have_link("Fund")

    fill_in "comment[content]", with: "this is a comment"
    click_on "Submit Comment"

    expect(page).to have_content("this is a comment")
  end
end
