FactoryBot.define do
  factory :owner do
    name                     { '太郎' }
    email                    { Faker::Internet.email }
    password                 { '111111' }
    password_confirmation    { '111111' }
  end
end
