require 'rails_helper'

describe "Admin" do
  it "can delete comments from project show" do
    #create admin user
    admin_user = create(:user)
    admin_user.roles << Role.create!(name: "admin_user")
    #create project
    #create two comments for project
    #visit projects/:slugged-project

    #expect page to have two comments

    #delete comment

    #expect current path to be projects/:slugged-project
    #expect page to have one comment
  end
end
