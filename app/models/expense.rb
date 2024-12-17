class Expense < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  validates :amount, :category, :purchased_on, :name, presence: true

  scope :billable, -> { where(billable: true) }
  scope :non_billable, -> { where(billable: false) }
end
