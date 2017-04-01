class Project < ApplicationRecord
  has_many :comments

  validates :name, :description, :total, :time, presence: true
  validates :slug, uniqueness: true

  has_many :user_funded_projects
  has_many :funders, through: :user_funded_projects, source: :user

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
