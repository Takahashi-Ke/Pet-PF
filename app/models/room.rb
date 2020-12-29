class Room < ApplicationRecord

  has_many :pet_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

end
