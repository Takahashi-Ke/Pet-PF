FactoryBot.define do
  factory :memory_comment do
    comment { Faker::Lorem.characters(number: 20) }
    association :pet
    association :memory
  end
end
