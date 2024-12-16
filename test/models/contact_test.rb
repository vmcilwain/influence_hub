require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  context 'associations' do
    should 'belong to organization' do
      assert_respond_to build(:contact), :organization
    end
  end
  
  context "validations" do
    # TODO: figureo ut what is going on with should matchers
    should 'validate presence of first name' do
      contact = build(:contact, first_name: nil)
      assert_not contact.valid?
      assert contact.errors[:first_name]
    end

    should 'validate presence of organization' do
      contact = build(:contact, organization: nil)
      assert_not contact.valid?
      assert contact.errors[:organization]
    end

    should 'validate presence of email or phone' do
      contact = build(:contact, email: nil, phone: nil)
      assert_not contact.valid?
      assert_equal ['Email or phone must be present'], contact.errors[:base]
    end

    should 'validate email format' do
      contact = build(:contact, email: 'userexample.com')
      assert_not contact.valid?
      assert contact.errors[:email]
    end

    should 'validate email uniqueness scoped to organization' do
      organization = create(:organization)
      create(:contact, email: 'user@example.com', organization: organization)
      assert_raises(ActiveRecord::RecordInvalid) do
        create(:contact, email: 'user@example.com', organization: organization)
      end
    end
  end
end
