class ChatsController < ApplicationController
  
  def show
    @pet = Pet.find(params[:pet_id])
    rooms = current_owner.pet.pet_rooms.pluck(:room_id)
    # 二人のチャット部屋があるか確認
    pet_room = PetRoom.find_by(pet_id: @pet.id, room_id: rooms)
    unless pet_room.nil?
      @room = pet_room.room
    else
      @room = Room.new
      @room.save
      PetRoom.create(pet_id: current_owner.pet.id, room_id: @room.id)
      PetRoom.create(pet_id: @pet.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new
  end

  def create
    chat = current_owner.pet.chats.new(chat_params)
    chat.room_id = params[:room_id]
    chat.save
    @chats = chat.room.chats
  end

  private
  def chat_params
    params.require(:chat).permit(:message)
  end

end
