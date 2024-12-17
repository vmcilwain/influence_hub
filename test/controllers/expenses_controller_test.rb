require 'test_helper'

class ExpensesControllerTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @campaign = create(:campaign, user: @user)
    @expense = create(:expense, user: @user, campaign: @campaign)
    sign_in @user
  end

  test 'requires authentication' do
    sign_out @user
    requires_authentication { get campaign_expenses_path(@campaign) }
    requires_authentication { get campaign_expense_path(@campaign, @expense) }
    requires_authentication { get new_campaign_expense_path(@campaign) }
    requires_authentication { post campaign_expenses_path(@campaign), params: { expense: attributes_for(:expense) } }
    requires_authentication { get edit_campaign_expense_path(@campaign, @expense) }
    requires_authentication { patch campaign_expense_path(@campaign, @expense), params: { expense: { name: 'Updated Expense' } } }
    requires_authentication { delete campaign_expense_path(@campaign, @expense) }
  end

  test 'should get index' do
    get campaign_expenses_path(@campaign)
    assert_response :success
  end

  test 'should get show' do
    get campaign_expense_path(@campaign, @expense)
    assert_response :success
  end

  context 'creating an expense' do
    should 'create expense' do
      get new_campaign_expense_path(@campaign)
      assert_response :success

      assert_difference 'Expense.count' do
        post campaign_expenses_path(@campaign), params: { expense: attributes_for(:expense) }
      end

      assert_redirected_to campaign_expenses_path(@campaign)
      assert_flash :success
    end

    should 'not create expense' do
      assert_no_difference 'Expense.count' do
        post campaign_expenses_path(@campaign), params: { expense: { name: '' } }
      end

      assert_response :success
      assert_flash :error
    end
  end

  context 'updating an expense' do
    should 'update expense' do
      get edit_campaign_expense_path(@campaign, @expense)
      assert_response :success

      patch campaign_expense_path(@campaign, @expense), params: { expense: { name: 'Updated Expense' } }
      assert_redirected_to campaign_expenses_path(@campaign)
      assert_flash :success
    end

    should 'not update expense' do
      patch campaign_expense_path(@campaign, @expense), params: { expense: { name: '' } }
      assert_response :success
      assert_flash :error
    end
  end

  test 'should destroy expense' do
    assert_difference 'Expense.count', -1 do
      delete campaign_expense_path(@campaign, @expense)
    end

    assert_redirected_to campaign_expenses_path(@campaign)
    assert_flash :success
  end
end
