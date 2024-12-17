FactoryBot.define do
  factory :expense do
    list_item
    amount { 100.00 }
    campaign
    sequence(:name) { |n| "Expense #{n}" }
    purchased_on { Date.today }
    user
  end

  factory :billable_expense, parent: :expense do
    billable { true }
  end
end
