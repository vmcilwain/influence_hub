require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should have_many(:campaigns).through(:promotions).dependent(:destroy)
    should have_many(:tasks).through(:campaigns)
  end
  
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:status)
  
  end
end
