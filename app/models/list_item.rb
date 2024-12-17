class ListItem < ApplicationRecord
  belongs_to :list

  validates :name, presence: true, uniqueness: { scope: :list_id, case_sensitive: false }
  validates :val, presence: true, uniqueness: { scope: :name, case_sensitive: false }

  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
end
