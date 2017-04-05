class Project < ApplicationRecord
  has_many :comments

  validates :name, :description, :total, :time, presence: true
  validates :slug, uniqueness: true

  has_many :user_funded_projects
  has_many :funders, through: :user_funded_projects, source: :user

  has_many :user_owned_projects
  has_many :owners, through: :user_owned_projects, source: :user

  before_validation :generate_slug

  enum ({status: [:active, :disabled]})

  def generate_slug
    self.slug = name.parameterize
  end

  def total_funds
    user_funded_projects.sum(:amount)
  end

  def self.closest_funded
    joins(:user_funded_projects)
      .group(:id)
      .select('projects.*, (projects.total - sum(user_funded_projects.amount)) AS funding_left')
      .order('funding_left asc')
      .having('(projects.total - sum(user_funded_projects.amount)) > 0')
      .limit(3)
  end
end
