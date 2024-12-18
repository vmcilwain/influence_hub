class AppDocument < ApplicationRecord
  has_rich_text :content
  
  belongs_to :user

  has_many :signatures, dependent: :destroy
  has_many :campaigns, through: :signatures, dependent: :destroy
  
  validates :name, :content, presence: true
  validates :status, inclusion: { in: %w[draft published] }

  enum :status, {
    draft: 0,
    published: 1 
  }
end
