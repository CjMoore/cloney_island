require 'rails_helper'

describe "a project owner can make changes to a project" do
  it "can edit a project" do
      user = create(:user)
      registered_user = create(:role)
      user.roles << registered_user
      project = create(:project, name: "Tiki Bar", image_url: "https://cdn.pastemagazine.com/www/system/images/photo_albums/tiki-bars/large/kaanapali-beach-hotel-tiki-gayotcom.jpg?1384968217")
      user.owned_projects << project
      owner = Role.create(name: "project_owner")
      user.roles << owner
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}"

      expect(page).to have_content(user.email)
      expect(page).to have_content("Tiki Bar")

      within(".owned-projects") do
        click_link("Edit")
      end
      expect(current_path).to eq(project_edit_path(project.slug))
      expect(page).to have_button("Update Project")
  end
end
