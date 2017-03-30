class Comment < ApplicationRecord
  validates :author, :content, presence: true 
  belongs_to :project
end
