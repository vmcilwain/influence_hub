FactoryBot.define do
  factory :organization do
    user
    name { Faker::Company.name }
  end

  factory :inactive_organization, parent: :organization do
    status { :inactive }
  end
end
