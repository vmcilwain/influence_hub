require 'application_system_test_case'

class TasksTest < BaseSystemTestCase
  setup do
    @campaign = create(:campaign)
    sign_in @campaign.user
  end

  test 'visiting the index' do
    visit campaign_tasks_url(@campaign)
    assert_selector 'h1', text: 'Tasks'
  end

  context 'when task is valid' do
    should 'create' do
      visit new_campaign_task_url(@campaign)

      fill_in :task_description, with: 'Task description'
      fill_in :task_due_on, with: Date.tomorrow
      select :Post, from: :task_kind
      select :Abandoned, from: :task_status
      click_on 'Create Task'

      assert_text 'Task was successfully created'
    end
  end

  context 'when task is invalid' do
    should 'not create when description is empty' do
      visit new_campaign_task_url(@campaign)

      fill_in :task_description, with: ''
      fill_in :task_due_on, with: Date.tomorrow
      select :Post, from: :task_kind
      select :Abandoned, from: :task_status
      click_on 'Create Task'

      assert_text "Description can't be blank"
    end

    should 'not create when due_on is empty' do
      visit new_campaign_task_url(@campaign)

      fill_in :task_description, with: 'Task description'
      fill_in :task_due_on, with: ''
      select :Post, from: :task_kind
      select :Abandoned, from: :task_status
      click_on 'Create Task'

      assert_text "Due on can't be blank"
      click_on 'Back'
    end
  end

  test 'should update Task' do
    task = create(:task, campaign: @campaign)

    visit edit_campaign_task_url(@campaign, task)

    fill_in 'Description', with: "Updated description"
    fill_in 'Due on', with: Date.yesterday
    click_on 'Update Task'

    assert_text 'Task was successfully updated'
  end

  test 'should destroy Task' do
    task = create(:task, campaign: @campaign)

    visit campaign_task_url(@campaign, task)
    
    click_on 'Destroy this task', match: :first

    assert_text 'Task was successfully destroyed'
  end
end
