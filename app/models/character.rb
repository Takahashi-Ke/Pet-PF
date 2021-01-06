class Character < ApplicationRecord
  
  has_many :pet_characters, dependent: :destroy
  
end
