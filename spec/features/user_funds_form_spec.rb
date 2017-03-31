require "rails_helper"

describe "when logged in user is on project show" do
  it "they click on the fund button and see a form" do
    project = create(:project)

    # user = create(:user)

    visit '/signup'

    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Doe"
    fill_in "Profile photo url", with: "https://s-media-cache-ak0.pinimg.com/originals/60/bd/d9/60bdd9ea7eaddc6d1aaadbe1132ad02e.jpg"
    fill_in "Email", with: "janedoe@example.com"
    fill_in "Phone", with: "555-867-5309"
    fill_in "Username", with: "janedoe"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
    expect(current_path).to eq(root_path)

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/projects/#{project.slug}"

    click_on("Fund")

    expect(page).to have_content("Amount")
    expect(page).to have_content("Credit card number")
  end
end
