require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations" do
    it { should validate_presence_of :author }
    it { should validate_presence_of :content }
  end

  context "relationships" do
    it { should belong_to :project }
  end
end
