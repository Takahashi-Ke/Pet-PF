FactoryBot.define do
  factory :diary do
    body                     { Faker::Lorem.characters(number: 100) }
    association :pet
  end
end