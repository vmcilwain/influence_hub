class AppDocument < ApplicationRecord
  has_rich_text :content
  
  belongs_to :user

  validates :name, :content, presence: true
  validates :status, inclusion: { in: %w[draft published] }

  enum :status, {
    draft: 0,
    published: 1 
  }
end
