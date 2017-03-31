class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :username, :email, :password, :phone, presence: true
  validates :email, :username, uniqueness: true
  has_many :user_roles
  has_many :roles, through: :user_roles

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
