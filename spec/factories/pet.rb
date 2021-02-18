FactoryBot.define do
  factory :pet do
    name             { 'マロン' }
    introduction     { Faker::Lorem.characters(number: 100) }
    birthday         { Faker::Time.between_dates(from: Date.today - 4000, to: Date.today) }
    gender           { 1 }
    type             { 2 }
    association :owner
  end
end
