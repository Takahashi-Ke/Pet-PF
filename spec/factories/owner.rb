FactoryBot.define do
  factory :owner do
    name                     { '太郎' }
    email                    { 'trou@example.com' }
    password                 { '111111' }
    password_confirmation    { '111111' }
  end
end
