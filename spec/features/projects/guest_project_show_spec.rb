require 'rails_helper'

describe "Guest" do
  it "goes to project show page" do
    project = Project.create!(name: "Test's", description: "test", total: 123, time: Faker::Time.forward(10, :morning), image_url: Faker::Avatar.image)

    visit "/projects/#{project.slug}"

    expect(page).to have_content("Test's")
    expect(page).to have_content("Description")
    expect(page).to have_content("test")
    expect(page).to have_content("Comments")
    expect(page).to have_link("Register/Sign in to fund")
  end
end
