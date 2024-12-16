require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should belong_to(:campaign)
    should have_many(:tasks).through(:campaign)
  end
  
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:status)
  
  end
end
