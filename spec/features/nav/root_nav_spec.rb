require "rails_helper"

describe "when user visits '/'" do
  it "they see a navbar with a logo and a link to login" do
    visit root_path

    within(".nav-wrapper") do
      expect(page).to have_content("Crowdfunder")
      expect(page).to have_content("Login")
      expect(page).to have_content("Projects")
    end
  end
end
