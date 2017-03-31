require 'rails_helper'

RSpec.describe UserFundedProject, type: :model do
  context "relationships" do
    it { should belong_to :user}
    it { should belong_to :project}
  end
end
