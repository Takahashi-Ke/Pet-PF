class PetRoom < ApplicationRecord
  belongs_to :pet
  belongs_to :room
end
