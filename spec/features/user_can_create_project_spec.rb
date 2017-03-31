require "rails_helper"

describe "as a reg user I can create a new project" do
  it "when I click 'create project' in nav bar" do

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

   within(".nav-wrapper") do
     expect(page).to have_content("Logout")
   end
    within(".nav-wrapper") do
      click_on("Start a Project")
    end
    save_and_open_page

    expect(current_path).to eq(new_project_path)
  end
end
