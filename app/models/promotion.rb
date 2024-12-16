class Promotion < ApplicationRecord
  belongs_to :campaign
  belongs_to :organization
end
