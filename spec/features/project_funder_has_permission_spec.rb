require 'rails_helper'

describe "project funder has permissions" do
  before(:each) do
    @user = create(:user)
    @role = Role.create(name: "project_funder")
    @user.roles << @role
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it "to visit root" do
    visit root_path
  end
end
