require 'rails_helper'

RSpec.describe Project, type: :model do
  # context "validations" do
  #   it { should validate_presence_of :name }
  #   it { should validate_presence_of :description }
  #   it { should validate_presence_of :total }
  #   it { should validate_presence_of :time }
  #   it { should validate_uniqueness_of :slug }
  # end

  context "relationships" do
    it { should have_many :comments }
  end
end
