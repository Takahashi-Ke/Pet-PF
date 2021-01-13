FactoryBot.define do
  factory :owner do
    name                     { |n| "TEST_OWNER#{n}"}
    email                    { |n| "TEST#{n}@example.com"}
    password                 { "Testuser1" }
    password_confirmation    { "Testuser1" }
  end
end