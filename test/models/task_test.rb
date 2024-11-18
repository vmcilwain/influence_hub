require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should belong_to(:campaign)
  end

  context 'validations' do
    should validate_presence_of(:description)
    should validate_presence_of(:status)
    should validate_presence_of(:kind)
  end
end
