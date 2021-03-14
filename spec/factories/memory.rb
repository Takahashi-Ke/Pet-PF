FactoryBot.define do
  factory :memory do
    title           { Faker::Lorem.characters(number: 10) }
    body            { Faker::Lorem.characters(number: 300) }
    association :pet
  end
end
