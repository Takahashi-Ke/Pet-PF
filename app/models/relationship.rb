class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'Pet'
  belongs_to :followed, class_name: 'Pet'
end
