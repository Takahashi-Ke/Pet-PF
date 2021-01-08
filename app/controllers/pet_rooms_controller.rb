class PetRoomsController < ApplicationController
  
  def index
    rooms = current_owner.pet.pet_rooms.pluck(:room_id)
    pet_rooms = PetRoom.where(room_id: rooms).where.not(pet_id: current_owner.pet)
    pets = pet_rooms.pluck(:pet_id)
    # binding.pry
    @pets = Pet.where(id: pets)
    @diary = Diary.new
  end

end
