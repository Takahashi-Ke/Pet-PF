FactoryBot.define do
  factory :memory do
    title           { Faker::Lorem.characters(number: 10) }
    body            { Faker::Lorem.characters(number: 300) }
    association :pet
    after(:create) do |memory|
      memory.memory_images << FactoryBot.create(:memory_image, memory_id: memory.id)
    end
  end
end
