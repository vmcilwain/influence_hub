require 'test_helper'

class ContactsControllerTest < BaseIntegrationTest
  setup do
    @organization = create(:organization)
    @contact = create(:contact, organization: @organization)
    @user = @organization.user

    sign_in(@user)
  end

  test 'requires authentication' do
    sign_out(@user)

    requires_authentication { get organization_contacts_url(@organization) }
    requires_authentication { get new_organization_contact_url(@organization) }
    requires_authentication { post organization_contacts_url(@organization), params: { contact: { first_name: 'John', last_name: 'Doe', email: '' } } }
    requires_authentication { get edit_organization_contact_url(@organization, @contact) }
    requires_authentication { patch organization_contact_url(@organization, @contact), params: { contact: { first_name: 'Jane' } } }
    requires_authentication { delete organization_contact_url(@organization, @contact) }
  end

  test 'should get index' do
    get organization_contacts_url(@organization)
    assert_response :success
  end

  test 'should get show' do
    get organization_contact_url(@organization, @contact)
    assert_response :success
  end

  test 'should get new' do
    get new_organization_contact_url(@organization)
    assert_response :success
  end

  context 'creating a contact' do
    should 'create a contact' do
      get new_organization_contact_url(@organization)
      assert_response :success

      assert_difference('Contact.count') do
        post organization_contacts_url(@organization), params: { contact: { first_name: 'John', last_name: 'Doe', email: 'user@example.com'} }
        assert_flash :success
        assert_redirected_to organization_contact_url(@organization, Contact.last)
      end
    end

    should 'show error' do
      assert_no_difference('Contact.count') do
        post organization_contacts_url(@organization), params: { contact: { first_name: 'John', last_name: 'Doe', email: '' } }
        assert_flash :error
      end
    end
  end

  context 'updating a contact' do
    should 'update a contact' do
      get edit_organization_contact_url(@organization, @contact)
      assert_response :success

      patch organization_contact_url(@organization, @contact), params: { contact: { first_name: 'Jane' } }
      assert_flash :success
      assert_redirected_to organization_contact_url(@organization, @contact)
    end

    should 'show error' do
      patch organization_contact_url(@organization, @contact), params: { contact: { email: '' } }
      assert_flash :error
    end
  end

  test 'should destroy contact' do
    assert_difference('Contact.count', -1) do
      delete organization_contact_url(@organization, @contact)
      assert_flash :success
      assert_redirected_to organization_contacts_url(@organization)
    end
  end
end
