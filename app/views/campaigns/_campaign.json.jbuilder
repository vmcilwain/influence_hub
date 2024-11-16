json.extract! campaign, :id, :user_id, :name, :description, :status, :rate, :engagement_rate, :reach, :clicks, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
