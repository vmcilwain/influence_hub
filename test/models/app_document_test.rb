require 'test_helper'

class AppDocumentTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:content)
    should define_enum_for(:status)
      .with_values(draft: 0, published: 1)
  end

  context 'associations' do
    should belong_to(:user)
    should have_many(:signatures).dependent(:destroy)
    should have_many(:campaigns).through(:signatures).dependent(:destroy)
  end
end
