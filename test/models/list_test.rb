require 'test_helper'

class ListTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :name
  end

  context 'associations' do
    should have_many :list_items
  end
end
