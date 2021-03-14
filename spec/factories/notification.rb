FactoryBot.define do
  factory :notification do
    action        { 'comment' }
    is_checked    { false }
    association :visited
    association :visitor
    association :diary
    association :memory
    association :diary_comment
    association :memory_comment
    association :room
  end
end
