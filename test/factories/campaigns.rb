FactoryBot.define do
  factory :campaign do
    user
    name { Faker::Company.name }
    status { :draft }
    rate { 1.5 } # TODO: think if this should default to 0 in the DB
  end

  factory :campaign_with_metrics, parent: :campaign do
    engagement_rate { 1.5 }
    reach { 1.5 }
    clicks { 1.5 }
  end

  factory :active_campaign, parent: :campaign do
    status { 1 }
  end

  factory :complete_campaign, parent: :campaign do
    status { 2 }
  end
end
