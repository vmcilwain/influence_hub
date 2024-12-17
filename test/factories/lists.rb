FactoryBot.define do
  factory :list do
    sequence(:name) { |n| "List #{n}" }
    sequence(:title) { |n| "Title #{n}" }
    sequence(:val) { |n| "Value #{n}" }
  end
end
