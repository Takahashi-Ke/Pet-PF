FactoryBot.define do
  factory :owner do
    name                     { Faker::Name.name }
    email                    { Faker::Internet.email }
    password                 { '111111' }
    password_confirmation    { '111111' }
  end
end
