require 'test_helper'

class CampaignPolicyTest < BasePolicyTest
  setup do
    @campaign = create(:campaign)
    @user = @campaign.user
    @other_user = create(:user)
  end

  test 'show' do
    assert_permit(@user, @campaign, :show)
    assert_forbid(@other_user, @campaign, :show)
  end

  test 'edit' do
    assert_permit(@user, @campaign, :edit)
    assert_forbid(@other_user, @campaign, :edit)
  end

  test 'update' do
    assert_permit(@user, @campaign, :update)
    assert_forbid(@other_user, @campaign, :update)
  end

  test 'destroy' do
    assert_permit(@user, @campaign, :destroy)
    assert_forbid(@other_user, @campaign, :destroy)
  end
end
