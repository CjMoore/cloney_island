class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :username, :email, :password, :phone, presence: true
  validates :email, :username, uniqueness: true


  has_many :user_funded_projects
  has_many :funded_projects, through: :user_funded_projects, source: :project

  has_many :user_roles
  has_many :roles, through: :user_roles

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
