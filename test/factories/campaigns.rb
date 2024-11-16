FactoryBot.define do
  factory :campaign do
    user { nil }
    name { "MyString" }
    description { "MyString" }
    status { 1 }
    rate { 1.5 }
    engagement_rate { 1.5 }
    reach { 1.5 }
    clicks { 1.5 }
  end
end
