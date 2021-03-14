FactoryBot.define do
  factory :pet_room do
    association :pet
    association :room
  end
end
