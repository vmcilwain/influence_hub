FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username  { Faker::Internet.username }
    sequence(:email) { |n| "user#{n}@example.com" }
    confirmed_at { Time.zone.now }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
