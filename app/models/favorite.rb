class Favorite < ApplicationRecord
  
  belongs_to :pet
  belongs_to :diary, optional: true
  belongs_to :memory, optional: true

  
end