FactoryBot.define do
  factory :organization do
    campaign
    user
    name { Faker::Company.name }
    status { :enabled }
  end
end
