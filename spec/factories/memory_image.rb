FactoryBot.define do
  factory :memory_image do
    image       { Faker::Internet.url }
    association :memory
  end
end
