class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :username, :email, :password, :phone, presence: true
  validates :email, :username, uniqueness: true
end
