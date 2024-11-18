json.extract! task, :id, :user_id, :campaign_id, :description, :status, :due_on, :kind, :created_at, :updated_at
json.url task_url(task, format: :json)
