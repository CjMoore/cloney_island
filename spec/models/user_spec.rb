require 'rails_helper'

RSpec.describe User, type: :model do
  context "secure password" do
    it { should have_secure_password }
  end

  context "relationships" do
    it { should have_many :funded_projects }
    it { should have_many :user_funded_projects }
  end

  context "validations" do
    it "user with all attributes is valid" do
      user = create(:user)
      expect(user).to be_valid
    end
    it "should not be valid without an email" do
      user = User.new(username: "a",
                      first_name: "a",
                      last_name: "b",
                      password: "c",
                      phone: "d")
      expect(user).to_not be_valid
    end
    it "should not be valid without a first_name" do
      user = User.new(username: "a",
                      email: "a",
                      last_name: "b",
                      password: "c",
                      phone: "d")
      expect(user).to_not be_valid
    end
    it "should not be valid without last_name" do
      user = User.new(username: "a",
                      email: "a",
                      first_name: "b",
                      password: "c",
                      phone: "d")
      expect(user).to_not be_valid
    end
    it "should not be valid without password" do
      user = User.new(username: "a",
                      email: "a",
                      first_name: "b",
                      last_name: "c",
                      phone: "d")
      expect(user).to_not be_valid
    end
    it "should not be valid without phone" do
      user = User.new(username: "a",
                      email: "a",
                      first_name: "b",
                      last_name: "c",
                      password: "d")
      expect(user).to_not be_valid
    end
  end
end
