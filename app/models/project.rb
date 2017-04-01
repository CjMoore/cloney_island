class Project < ApplicationRecord
  has_many :comments
  validates :name, :description, :total, presence: true
  validates :slug, uniqueness: true

  has_many :user_funded_projects
  has_many :funders, through: :user_funded_projects, source: :user

  has_many :user_owned_projects
  has_many :owners, through: :user_owned_projects, source: :user

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
