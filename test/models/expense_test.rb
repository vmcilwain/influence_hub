require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :amount
    should validate_presence_of :category
    should validate_presence_of :purchased_on
    should validate_presence_of :name
  end

  context 'associations' do
    should belong_to :campaign
    should belong_to :user
  end
end
