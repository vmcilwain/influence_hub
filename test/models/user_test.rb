require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :first_name
    should validate_presence_of :last_name
  end

  context 'associations' do
    should have_many(:campaigns).dependent(:destroy)
    should have_many(:tasks).through(:campaigns).dependent(:destroy)
  end
end
