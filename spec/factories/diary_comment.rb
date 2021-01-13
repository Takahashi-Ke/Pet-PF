FactoryBot.define do
  factory :diary_comment do
    comment           { Faker::Lorem.characters(number: 20) }
    association :pet
    association :diary
  end
end