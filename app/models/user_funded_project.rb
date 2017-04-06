class UserFundedProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :amount, :credit_card_number, presence: true
end
