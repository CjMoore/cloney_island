require 'rails_helper'

RSpec.describe UserRole, type: :model do
  context "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:role_id) }
  end

  context "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end

  it "methods" do
    user = create(:user, username: "user")
    user2 = create(:user, username: "user2")
    user3 = create(:user, username: "user3")
    user4 = create(:user, username: "user4")
    funder = Role.create(name: "project_funder", id: 3)
    admin = Role.create(name: "admin_user", id: 4)
    owner = Role.create(name: "project_owner", id: 2)
    reg = Role.create(name: "registered_user", id: 1)
    user.roles << funder
    user2.roles << admin
    user3.roles << owner
    user4.roles << reg
    expect(UserRole.num_of_admins).to eq(1)
    expect(UserRole.num_of_project_owners).to eq(1)
    expect(UserRole.num_of_project_funders).to eq(1)
    expect(UserRole.num_of_registered_users).to eq(1)
  end
end
