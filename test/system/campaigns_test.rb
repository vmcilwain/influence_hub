require 'application_system_test_case'

class CampaignsTest < BaseSystemTestCase
  setup do
    @user = create(:user)
  end

  test 'visiting the index' do
    sign_in @user
    visit campaigns_url
    assert_selector 'h1', text: 'Campaigns'
  end

  context 'campaign creation' do
    should 'should create campaign' do
      sign_in @user

      visit new_campaign_url
  
      fill_in 'Name', with: 'New Campaign'
      fill_in 'Rate', with: 10
      
      click_on 'Create Campaign'
  
      assert_text 'Campaign was successfully created'
    end

    should 'should not create campaign if name is empty' do
      sign_in @user

      visit new_campaign_url
  
      fill_in 'Rate', with: 10
      
      click_on 'Create Campaign'
  
      assert_text "Name can't be blank"
    end

    should 'should not create campaign if rate is empty' do
      sign_in @user

      visit new_campaign_url
  
      fill_in 'Name', with: 'New Campaign'
      
      click_on 'Create Campaign'
  
      assert_text 'Rate is not a number'
    end
  end

  context 'campaign update' do
    should 'should update Campaign' do
      campaign = create(:campaign, user: @user)
      sign_in @user  
      
      visit edit_campaign_url(campaign)

      fill_in :campaign_name, with: 'Updated Campaign Name'
      fill_in :campaign_rate, with: 5
      fill_in :campaign_reach, with: 10
      select :Active, from: :campaign_status
      click_on 'Update Campaign'

      assert_text 'Campaign was successfully updated'
    end

    should 'should not update Campaign if name is empty' do
      campaign = create(:campaign, user: @user)
      sign_in @user
      
      visit edit_campaign_url(campaign)

      fill_in :campaign_name, with: ''
      click_on 'Update Campaign'

      assert_text "Name can't be blank"
    end

    should 'should not update Campaign if rate is empty' do
      campaign = create(:campaign, user: @user)
      sign_in @user
      
      visit edit_campaign_url(campaign)

      fill_in :campaign_rate, with: ''
      click_on 'Update Campaign'

      assert_text 'Rate is not a number'
    end
  end

  test 'should destroy Campaign' do
    campaign = create(:campaign, user: @user)
    sign_in @user

    visit campaign_url(campaign)
    page.accept_confirm do
      click_on :Delete, match: :first
    end
    assert_text 'Campaign was successfully destroyed'
  end
end
