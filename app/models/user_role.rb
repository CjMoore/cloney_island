class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates :user_id, :role_id, presence: true

  def self.num_of_registered_users
    where(role_id: 1).count
  end

  def self.num_of_project_owners
    where(role_id: 2).count
  end

  def self.num_of_project_funders
    where(role_id: 3).count
  end

  def self.num_of_admins
    where(role_id: 4).count
  end
end
