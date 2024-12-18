require 'test_helper'

class SignatureTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to :campaign
    should belong_to :document
  end
end
