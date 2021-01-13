FactoryBot.define do
  factory :pet_personality do
    personality         { [1,3,5] }
    association :pet
  end
end