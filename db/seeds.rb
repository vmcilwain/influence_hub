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

org = user.organizations.create!(
  name: 'Acme, Inc.'
)

3.times do
  org.contacts.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )
end 

campaign = Campaign.create!(
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

list = List.first_or_create!(name: 'Expenses')

expense_list_items = [
  'Travel',
  'Meals',
  'Office Supplies',
  'Software',
  'Hardware',
  'Professional Services',
  'Training',
  'Marketing',
  'Miscellaneous'
]

expense_list_items.each do |list_item|
  list.list_items.create!(name: list_item, val: list_item)

  Expense.create!(
    name: Faker::Lorem.sentence,
    category: list_item,
    amount: Faker::Number.decimal(l_digits: 2),
    purchased_on: Time.zone.now,
    campaign: campaign,
    user: user
  )
end
