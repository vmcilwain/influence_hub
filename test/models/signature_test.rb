require 'test_helper'

class SignatureTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to :campaign
    should belong_to :document
  end

  context 'validations' do
    should validate_presence_of :signee_email
    should define_enum_for(:status).with_values(%i[pending signed])
  end

  context 'callbacks' do
    should 'generate external_id on create' do
      signature = Signature.create(signee_email: 'test@example.com', campaign: create(:campaign), document: create(:app_document))
      
      assert_not_nil signature.external_id
    end

    should 'generate unique external_id' do
      signature1 = Signature.create(signee_email: 'test1@example.com', campaign: create(:campaign), document: create(:app_document))
      signature2 = Signature.create(signee_email: 'test2@example.com', campaign: create(:campaign), document: create(:app_document))
      # debugger
      assert_not_equal signature1.external_id, signature2.external_id
    end

    should 'generate security_code on create' do
      signature = Signature.create(signee_email: 'test@example.com', campaign: create(:campaign), document: create(:app_document))

      assert_not_nil signature.security_code
    end

    should 'generate unique security_code' do
      signature1 = Signature.create(signee_email: 'test1@example.com', campaign: create(:campaign), document: create(:app_document))
      signature2 = Signature.create(signee_email: 'test2@example.com', campaign: create(:campaign), document: create(:app_document))
      # debugger
      assert_not_equal signature1.security_code, signature2.security_code
    end
  end
end
