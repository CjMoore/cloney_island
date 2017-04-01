require "rails_helper"

describe "as a reg user I can create a new project" do
  it "when I click 'create project' in nav bar" do
    user = create(:user)
    role = create(:role)
    user.roles << role
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit'/'

   within(".nav-wrapper") do
     expect(page).to have_content("Logout")
   end
    within(".nav-wrapper") do
      click_on("Start a Project")
    end

    expect(current_path).to eq(new_project_path)
  end
end
