FactoryBot.define do
  factory :campaign do
    user
    name { Faker::Business.name }
    description
    status { 1 }
    rate { 1.5 } # TODO: think if this should default to 0 in the DB
  end

  factory :with_metrics, parent: :campaign do
    engagement_rate { 1.5 }
    reach { 1.5 }
    clicks { 1.5 }
  end
end
