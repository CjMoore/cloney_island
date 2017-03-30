class Project < ApplicationRecord
  has_many :comments
  validates :name, :description, :total, :time, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
