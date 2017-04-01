require "rails_helper"

describe "when user is logged in" do
  it "they are able to update their user information" do
    user = create(:user)
    role = create(:role)
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}"

    click_on("Edit")

    expect(current_path).to eq("/#{user.slug}/edit")
    
  end
end
