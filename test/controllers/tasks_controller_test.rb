require 'test_helper'

class TasksControllerTest < BaseIntegrationTest
  setup do
    @campaign = create(:campaign)
  end

  test 'requires authentication' do
    task = create(:task, campaign: @campaign)
    requires_authentication { get campaign_tasks_url(@campaign) }
    requires_authentication { get new_campaign_task_url(@campaign) }
    requires_authentication { post campaign_tasks_url(@campaign), params: { task: attributes_for(:task) } }
    requires_authentication { get edit_campaign_task_url(@campaign, task) }
    requires_authentication { patch campaign_task_url(@campaign, task), params: { task: { description: 'Updated description' } } }
    requires_authentication { delete campaign_task_url(@campaign, task) }
  end

  test 'should get index' do
    sign_in @campaign.user
    
    get campaign_tasks_url(@campaign)
    assert_response :success
  end

  context 'task creation' do
    should 'create task' do
      sign_in @campaign.user

      get new_campaign_task_url(@campaign)
      assert_response :success

      assert_difference('Task.count') do
        post campaign_tasks_url(@campaign), params: { task: attributes_for(:task) }
      end

      assert_redirected_to campaign_task_url(@campaign, Task.last)
    end

    should 'not create a task if description is empty' do
      sign_in @campaign.user

      assert_no_difference('Task.count') do
        post campaign_tasks_url(@campaign), params: { task: attributes_for(:task, description: '') }
      end

      assert_response :unprocessable_entity
    end

    should 'not create a task if status is empty' do
      sign_in @campaign.user

      assert_no_difference('Task.count') do
        post campaign_tasks_url(@campaign), params: { task: attributes_for(:task, status: nil) }
      end

      assert_response :unprocessable_entity
    end

    should 'not create a task if kind is empty' do
      sign_in @campaign.user

      assert_no_difference('Task.count') do
        post campaign_tasks_url(@campaign), params: { task: attributes_for(:task, kind: nil) }
      end

      assert_response :unprocessable_entity
    end
  end

  test 'should show task' do
    task = create(:task, campaign: @campaign)
    sign_in @campaign.user

    get campaign_task_url(@campaign, task)
    assert_response :success
  end

  context 'task update' do
    should 'successfully update' do
      task = create(:task, campaign: @campaign)
      sign_in @campaign.user

      get edit_campaign_task_url(@campaign, task)
      assert_response :success

      patch campaign_task_url(@campaign, task), params: { task: { due_on: Date.tomorrow } }
      assert_redirected_to campaign_task_url(@campaign, task)
    end

    should 'not update task if description is empty' do
      task = create(:task, campaign: @campaign)
      sign_in @campaign.user

      patch campaign_task_url(@campaign, task), params: { task: { description: '' } }
      assert_response :unprocessable_entity
    end

    should 'not update task if status is empty' do
      task = create(:task, campaign: @campaign)
      sign_in @campaign.user

      patch campaign_task_url(@campaign, task), params: { task: { status: nil } }
      assert_response :unprocessable_entity
    end
  end

  test 'should destroy task' do
    task = create(:task, campaign: @campaign)
    sign_in @campaign.user

    assert_difference('Task.count', -1) do
      delete campaign_task_url(@campaign, task)
    end

    assert_redirected_to campaign_tasks_url(@campaign)
  end
end
