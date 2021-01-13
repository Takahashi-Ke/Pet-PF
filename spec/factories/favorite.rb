FactoryBot.define do
  factory :favorite do
    association :pet
    association :diary
    association :memory
  end
end