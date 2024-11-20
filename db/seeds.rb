# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(
  first_name: 'Joe',
  last_name: 'Smith',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now
)

Campaign.create!(
  user: user,
  name: 'Instagram Campaign',
  rate: 1.5 
)

%i[not_started in_progress complete abandoned].each do |status|
  2.times do
    Task.create!(
      user: user,
      campaign: Campaign.first,
      description: Faker::Lorem.sentence,
      details: Faker::Lorem.sentences(number: 3).join(' '),
      due_on: Time.zone.now,
      status: status,
      kind: %i[deliverable milestone approval post blog].sample
    )
  end
end
