FactoryBot.define do
  factory :signature do
    association :document, factory: :app_document
    campaign
    sequence(:signee_email) { |n| "signee_email#{n}@example.com}" }
    status { :pending }
    signature { 'signature' }
  end
end