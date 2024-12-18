FactoryBot.define do
  factory :app_document do
    user
    status { :draft }
    name { "test document" }
    content { "test content" }
  end
end
