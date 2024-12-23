require "test_helper"

class SignaturesControllerTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @campaign = create(:campaign, user: @user)
    @document = create(:app_document, user: @user)
    @signature = create(:signature, campaign: @campaign, document: @document)
    sign_in @user
  end

  test 'requires authentication' do
    sign_out @user

    requires_authentication { get document_signatures_url(@document) }
    requires_authentication { get document_signature_url(@document, @signature) }
    requires_authentication { get new_document_signature_url }
    requires_authentication { post document_signatures_url, params: { signature: attributes_for(:signature) } }
    requires_authentication { get edit_document_signature_url(@document, @signature) }
    requires_authentication { patch document_signature_url(@document, @signature), params: { signature: attributes_for(:signature) } }
    requires_authentication { delete document_signature_url(@document, @signature) }
  end

  test 'should get index' do
    get document_signatures_url(@document)
    assert_response :success
  end
  
  context 'creating a signature' do
    should 'create signature' do
      get new_document_signature_url(@document)
      assert_response :success
  
      assert_difference('Signature.count') do
        post document_signatures_url(@document),
          params: { signature: attributes_for(:signature, campaign_id: @campaign.id) }
      end
  
      assert_redirected_to document_signature_url(@document, Signature.last)
      assert_flash :success
    end
  
    should 'not create signature with invalid attributes' do
      assert_no_difference('Signature.count') do
        post document_signatures_url(@document),
          params: { signature: { signee_email: nil } }
      end
  
      assert_response :success
      assert_flash :error
    end
  end
  
  test 'should show signature' do
    get document_signature_url(@document, @signature)
    assert_response :success
  end
  
  context 'updating signature' do
    should 'update signature' do
      get edit_document_signature_url(@document, @signature)
      assert_response :success
  
      patch document_signature_url(@document, @signature),
        params: { signature: { signee_email: 'test@example.com' } }
  
      assert_redirected_to document_signature_url(@document, @signature)
      assert_flash :success
    end
  
    should 'not update signature with invalid attributes' do
      patch document_signature_url(@document, @signature),
        params: { signature: { signee_email: nil } }
  
      assert_flash :error
    end
  end
  
  test 'should destroy signature' do
    assert_difference('Signature.count', -1) do
      delete document_signature_url(@document, @signature)
    end
  
    assert_redirected_to document_signatures_url(@document)
    assert_flash :success
  end

  test 'review signature' do
    sign_out @user

    get review_signature_url(external_id: @signature.external_id)
    assert_response :success
  end

  context 'signing a signature' do
    should 'sign signature' do
      sign_out @user

      put sign_signature_url(external_id: @signature.external_id),
        params: { signature: {
          signee_signature: @signature.signature,
          security_code: @signature.security_code
          }
        }

      assert_flash :success
      assert_response :found
    end

    should 'not sign signature with without a signature' do
      put sign_signature_url(external_id: @signature.external_id),
        params: { signature: {
          signee_signature: nil
          }
        }

      assert_flash :error
    end

    should 'not sign signature with an incorrect security code' do
      put sign_signature_url(external_id: @signature.external_id),
        params: { signature: {
          signee_signature: @signature.signature,
          security_code: 'invalid_security_code'
          }
        }

      assert_flash :error
    end

    should 'not sign signature with an no security code' do
      put sign_signature_url(external_id: @signature.external_id),
        params: { signature: {
          signee_signature: @signature.signature,
          security_code: ''
          }
        }

      assert_flash :error
    end
  end
end
