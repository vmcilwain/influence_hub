require "test_helper"

class OrganizationsControllerTest < BaseIntegrationTest
  setup do
    @organization = create(:organization)
    @user = @organization.user
    sign_in @user
  end

  test 'requires authentication' do
    sign_out @user

    requires_authentication { get organizations_url }
    requires_authentication { get new_organization_url }
    requires_authentication { post organizations_url, params: { organization: { name: 'My Organization' } } }
    requires_authentication { get edit_organization_url(@organization) }
    requires_authentication { patch organization_url(@organization), params: { organization: { status: 'inactive' } } }
    requires_authentication { delete organization_url(@organization) }
  end

  test 'should get index' do
    get organizations_url
    assert_response :success
  end

  test 'should get show' do
    get organization_url(@organization)
    assert_response :success
  end

  context 'organization creation' do
    should 'create organization' do
      get new_organization_url
      assert_response :success

      assert_difference('Organization.count', 1) do
        post organizations_url, params: { organization: { name: 'My Organization' } }
        assert_redirected_to organization_url(Organization.last)
        assert_flash(:success)
      end
    end

    should 'not create organization' do
      assert_no_difference('Organization.count') do
        post organizations_url, params: { organization: { name: '' } }
        assert_flash(:error)
      end
    end

    should 'associate campaign with organization' do
      campaign = create(:campaign)
      post organizations_url, params: { organization: { name: 'My Organization', campaign_ids: [campaign.id] } }
      assert_equal Organization.last.campaigns, [campaign]
    end
  end

  context 'organization update' do
    should 'update organization' do
      get edit_organization_url(@organization)
      assert_response(:success)

      patch organization_url(@organization), params: { organization: { status: 'inactive' } }
      assert_redirected_to organization_url(@organization)
      assert_equal 'inactive', @organization.reload.status
      assert_flash(:success)
    end

    should 'not update organization' do
      patch organization_url(@organization), params: { organization: { name: '' } }
      assert_flash(:error)
    end

    should 'disassociate campaign with organization' do
      campaign = create(:campaign)
      @organization.campaigns << campaign

      patch organization_url(@organization), params: { organization: { campaign_ids: [] } }
      assert_equal Organization.last.campaigns, []
    end
  end

  test 'should destroy organization' do
    assert_difference('Organization.count', -1) do
      delete organization_url(@organization)
      assert_redirected_to organizations_url
      assert_flash(:success)
    end
  end
end
