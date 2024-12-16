class Campaign < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy
  has_one :organization
  
  validates :name, presence: true
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum :status, { draft: 0, active: 1, complete: 2 }
end
