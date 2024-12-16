FactoryBot.define do
  factory :contact do
    organization
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :contact_with_phone, parent: :contact do
    email { nil }
    phone { Faker::PhoneNumber.phone_number }
  end
end
