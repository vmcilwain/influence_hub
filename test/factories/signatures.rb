FactoryBot.define do
  factory :signature do
    association :document, factory: :app_document
    campaign
    external_id { SecureRandom.uuid }
    sequence(:signee_email) { |n| "signee_email#{n}@example.com}" }
    status { :pending }
  end
end