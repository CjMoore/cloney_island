require 'rails_helper'

RSpec.describe Project, type: :model do
  context "validations" do
    it "should be valid with all attributes" do
      project = create(:project)
      expect(project).to be_valid
    end
    it "should be invalid without name" do
      project = Project.new(name: "a",
                            total: 1,
                            time: "12/12/2017",
                            )
      expect(project).to be_invalid
    end
    it "should be invalid without total" do
      project = Project.new(name: "a",
                            description: "b",
                            time: "12/12/2017",
                            )
      expect(project).to be_invalid
    end
    it "should be invalid without time" do
      project = Project.new(name: "a",
                            description: "b",
                            total: 1
                            )
      expect(project).to be_invalid
    end
  end

  context "relationships" do
    it { should have_many :user_funded_projects }
    it { should have_many :funders }
    it { should have_many :comments }
  end
end
