FactoryBot.define do
  factory :list_item do
    list
    sequence(:name) { |n| "item name #{n}" }
    val { "test value" }
  end
end
