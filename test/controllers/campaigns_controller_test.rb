require 'test_helper'

class CampaignsControllerTest < BaseIntegrationTest
  setup do
    @campaign = create(:campaign)
    user = @campaign.user
    sign_in user
  end

  test 'requires authentication' do
    sign_out @campaign.user

    requires_authentication { get campaigns_url }
    requires_authentication { get new_campaign_url }
    requires_authentication { post campaigns_url, params: { campaign: attributes_for(:campaign) } }
    requires_authentication { get campaign_url(@campaign) }
    requires_authentication { get edit_campaign_url(@campaign) }
    requires_authentication { patch campaign_url(@campaign), params: { campaign: { name: 'Updated Campaign Name' } } }
    requires_authentication { delete campaign_url(@campaign) }
  end

  test 'should get index' do
    get campaigns_url
    assert_response :success
  end

  test 'should get new' do
    get new_campaign_url
    assert_response :success
  end

  test 'should create campaign' do
    assert_difference('Campaign.count') do
      post campaigns_url, params: { campaign: attributes_for(:campaign) }
    end

    assert_redirected_to campaign_url(Campaign.last)
  end

  test 'should show campaign' do
    get campaign_url(@campaign)
    assert_response :success
  end

  test 'should get edit' do
    get edit_campaign_url(@campaign)
    assert_response :success
  end

  test 'should update campaign' do
    patch campaign_url(@campaign), params: { campaign: { rate: 100 } }
    assert_redirected_to campaign_url(@campaign)
  end

  test 'should destroy campaign' do
    assert_difference('Campaign.count', -1) do
      delete campaign_url(@campaign)
    end

    assert_redirected_to campaigns_url
  end
end
