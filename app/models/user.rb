class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :username, :email, :password, :phone, presence: true
  validates :email, :username, uniqueness: true

  has_many :user_funded_projects
  has_many :funded_projects, through: :user_funded_projects, source: :project

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :user_owned_projects
  has_many :owned_projects, through: :user_owned_projects, source: :project

  before_validation :generate_slug
  # before_update :generate_slug

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def project_funder?
    roles.exists?(name: "project_funder")
  end

  def project_owner?
    roles.exists?(name: "project_owner")
  end

  def admin_user?
    roles.exists?(name: "admin_user")
  end

  def deactive_user?
    roles.exists?(name: "deactive_user")
  end

  def my_total_amount_funded(project)
    user_funded_projects.where(project_id: project.id).sum(:amount)
  end

private

  def generate_slug
    self.slug = username.parameterize
  end
end
