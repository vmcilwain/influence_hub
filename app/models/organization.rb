class Organization < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  
  has_many :tasks, through: :campaign
  
  validates :name, :status, presence: true
  
  enum :status, { active: 0, inactive: 1 }
end
