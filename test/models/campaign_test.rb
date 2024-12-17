require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should have_many(:tasks).dependent(:destroy)
    should have_many(:organizations).through(:promotions).dependent(:destroy)
    should have_many(:expenses).dependent(:destroy)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:rate)
    should validate_numericality_of(:rate).is_greater_than_or_equal_to(0)
  end
end
