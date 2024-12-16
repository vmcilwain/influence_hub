class Organization < ApplicationRecord
  belongs_to :user
  
  has_many :promotions, dependent: :destroy
  has_many :campaigns, through: :promotions, dependent: :destroy
  has_many :contacts
  has_many :tasks, through: :campaigns
  
  validates :name, :status, presence: true

  enum :status, { active: 0, inactive: 1 }
end
