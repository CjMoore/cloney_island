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
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:phone) }
  end
end
