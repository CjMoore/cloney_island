require 'rails_helper'

RSpec.describe UserFundedProject, type: :model do
  context "relationships" do
    it { should belong_to :user}
    it { should belong_to :project}
  end

  context "validations" do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :credit_card_number }
  end
end
