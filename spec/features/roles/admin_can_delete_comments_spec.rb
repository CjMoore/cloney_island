require 'rails_helper'

describe "Admin" do
  it "can delete comments from project show" do
    user = create(:user)
    user.roles << Role.create!(name: "admin_user")
    project = create(:project)
    project.comments << Comment.create!(author: "judge joe brown", content: "no comment", project_id: project.id)
    project.comments << Comment.create!(author: "lemonSpark", content: "lemon lemon lemon", project_id: project.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/projects/#{project.slug}"

    comments = page.all(".comment-thing")

    within(comments[0]) do
      click_on "Delete Comment"
    end

    expect(current_path).to eq "/projects/#{project.slug}"
    expect(page).to have_content("lemonSpark")
    expect(page).to_not have_content("judge joe brown")
  end
end
