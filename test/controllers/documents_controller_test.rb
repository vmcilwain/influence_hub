require 'test_helper'

class DocumentsControllerTest < BaseIntegrationTest
  setup do
    @document = create(:app_document)
    @user = @document.user
    sign_in @user
  end

  test 'requires authentication' do
    sign_out @user
    requires_authentication { get documents_url }
    requires_authentication { get document_url(@document) }
    requires_authentication { get new_document_url }
    requires_authentication { post documents_url, params: { app_document: attributes_for(:app_document) } }
    requires_authentication { get edit_document_url(@document) }
    requires_authentication { patch document_url(@document), params: { app_document: attributes_for(:app_document) } }
    requires_authentication { delete document_url(@document) }
  end

  test 'should get index' do
    get documents_url
    assert_response :success
  end
  
  context 'creating a document' do
    should 'create document' do
      get new_document_url
      assert_response :success
  
      assert_difference('AppDocument.count') do
        post documents_url, params: { app_document: attributes_for(:app_document) }
      end
  
      assert_redirected_to document_url(AppDocument.last)
      assert_flash :success
    end
  
    should 'not create document with invalid attributes' do
      assert_no_difference('AppDocument.count') do
        post documents_url, params: { app_document: { name: nil } }
      end
  
      assert_flash :error
    end
  end
  
  test 'should show document' do
    get document_url(@document)
    assert_response :success
  end
  
  context 'updating document' do
    should 'update document' do
      get edit_document_url(@document)
      assert_response :success
  
      patch document_url(@document), params: { app_document: { name: 'Updated Name' } }
      assert_redirected_to document_url(@document)
      assert_flash :success
    end
  
    should 'not update document with invalid attributes' do
      patch document_url(@document), params: { app_document: { name: nil } }
      assert_flash :error
    end
  end
  
  test 'should destroy document' do
    assert_difference('AppDocument.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
    assert_flash :success
  end
end
