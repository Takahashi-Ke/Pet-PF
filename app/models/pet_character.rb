class PetCharacter < ApplicationRecord
  
  belongs_to :pet
  belongs_to :character
  
end
