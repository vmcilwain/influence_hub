require 'test_helper'

class CampaignsControllerTest < BaseIntegrationTest
  setup do
    @user = create(:user)
  end

  test 'requires authentication' do
    campaign = create(:campaign)
    
    requires_authentication { get campaigns_url }
    requires_authentication { get new_campaign_url }
    requires_authentication { post campaigns_url, params: { campaign: attributes_for(:campaign) } }
    requires_authentication { get campaign_url(campaign) }
    requires_authentication { get edit_campaign_url(campaign) }
    requires_authentication { patch campaign_url(campaign), params: { campaign: { name: 'Updated Campaign Name' } } }
    requires_authentication { delete campaign_url(campaign) }
  end

  test 'should get index' do
    sign_in @user
    
    get campaigns_url
    assert_response :success
  end

  context 'campaign creation' do
    should 'should create a campaign' do
      sign_in @user

      get new_campaign_url
      assert_response :success

      assert_difference('Campaign.count') do
        post campaigns_url, params: { campaign: attributes_for(:campaign) }
      end

      assert_redirected_to campaign_url(Campaign.last)
    end

    should 'should not create campaign if name is empty' do
      sign_in @user

      assert_no_difference('Campaign.count') do
        post campaigns_url, params: { campaign: attributes_for(:campaign, name: '') }
      end

      assert_response :unprocessable_entity
    end

    should 'should not create campaign if rate is empty' do
      sign_in @user

      assert_no_difference('Campaign.count') do
        post campaigns_url, params: { campaign: attributes_for(:campaign, rate: '') }
      end

      assert_response :unprocessable_entity
    end
  end

  test 'should show campaign' do
    campaign = create(:campaign, user: @user)
    sign_in @user
    get campaign_url(campaign)
    assert_response :success
  end

  context 'campaign update' do
    should 'should update campaign' do
      campaign = create(:campaign, user: @user)
      sign_in @user
      get edit_campaign_url(campaign)
      assert_response :success

      patch campaign_url(campaign), params: { campaign: { rate: 100 } }
      assert_redirected_to campaign_url(campaign)
    end

    should 'should not update campaign if name is empty' do
      campaign = create(:campaign, user: @user)
      sign_in @user

      patch campaign_url(campaign), params: { campaign: { name: '' } }
      assert_response :unprocessable_entity
    end

    should 'should not update campaign if rate is empty' do
      campaign = create(:campaign, user: @user)
      sign_in @user

      patch campaign_url(campaign), params: { campaign: { rate: '' } }
      assert_response :unprocessable_entity
    end
  end

  test 'should destroy campaign' do
    campaign = create(:campaign, user: @user)
    sign_in @user

    assert_difference('Campaign.count', -1) do
      delete campaign_url(campaign)
    end

    assert_redirected_to campaigns_url
  end
end
