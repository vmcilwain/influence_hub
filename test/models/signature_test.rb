require 'test_helper'

class SignatureTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to :campaign
    should belong_to :document
  end

  context 'validations' do
    should validate_presence_of :signee_email
    should define_enum_for(:status).with_values(%i[pending signed])
    should validate_presence_of :signature
  end

  context 'callbacks' do
    should 'generate external_id on create' do
      signature = Signature.create(signee_email: 'test@example.com', campaign: create(:campaign), document: create(:app_document))
      
      assert_not_nil signature.external_id
    end

    should 'generate unique external_id' do
      signature1 = Signature.create(signee_email: 'test1@example.com', campaign: create(:campaign), document: create(:app_document))
      signature2 = Signature.create(signee_email: 'test2@example.com', campaign: create(:campaign), document: create(:app_document))

      assert_not_equal signature1.external_id, signature2.external_id
    end

    should 'generate security_code on create' do
      signature = Signature.create(signee_email: 'test@example.com', campaign: create(:campaign), document: create(:app_document))

      assert_not_nil signature.security_code
    end

    should 'generate unique security_code' do
      signature1 = Signature.create(signee_email: 'test1@example.com', campaign: create(:campaign), document: create(:app_document))
      signature2 = Signature.create(signee_email: 'test2@example.com', campaign: create(:campaign), document: create(:app_document))

      assert_not_equal signature1.security_code, signature2.security_code
    end
  end

  context '#signature_verified' do
    should 'return true if signature matches' do
      signature = create(:signature)
      
      assert signature.signature_verified({ signee_signature: signature.signature, security_code: signature.security_code })
      signature.reload

      assert_equal 'signed', signature.status
      assert_not_nil signature.signed_at
      assert_equal signature.signature, signature.signee_signature
    end

    should 'return false if signature does not match' do
      signature = create(:signature, signature: 'signature')
      assert_not signature.signature_verified({ signee_signature: 'invalid_signature', security_code: signature.security_code })
    end

    should 'return false if security_code does not match' do
      signature = create(:signature)
      assert_not signature.signature_verified({ signee_signature: signature.signature, security_code: 'invalid_security_code' })
    end
  end
end
