FactoryBot.define do
  factory :task do
    user
    campaign
    description { 'A brief description' }
    status { 'not_started' }
    due_on { '2024-11-16' }
    kind { 'deliverable' }
  end
end
