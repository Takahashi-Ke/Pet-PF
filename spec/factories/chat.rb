FactoryBot.define do
  factory :chat do
    message     { Faker::Lorem.characters(number: 20) }
    association :pet
    association :room
  end
end