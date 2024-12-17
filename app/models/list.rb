class List < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true, uniqueness: { scope: :name, case_sensitive: false }
  validates :val, presence: true, uniqueness: { scope: :title, case_sensitive: false }
end
