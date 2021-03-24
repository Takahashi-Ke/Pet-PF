class ChatsController < ApplicationController
  def show
    @pet = Pet.find(params[:pet_id])
    if @pet.id != current_owner.pet.id
      rooms = current_owner.pet.pet_rooms.pluck(:room_id)
      # 二人のチャット部屋があるか確認
      pet_room = PetRoom.find_by(pet_id: @pet.id, room_id: rooms)
      if pet_room.nil?
        @room = Room.create
        PetRoom.create(pet_id: current_owner.pet.id, room_id: @room.id)
        PetRoom.create(pet_id: @pet.id, room_id: @room.id)
      else
        @room = pet_room.room
      end
      @chats = @room.chats
      @chat = Chat.new
    else
      redirect_to root_path
    end
  end

  def create
    @pet = Pet.find(params[:pet_id])
    @room = Room.find(params[:room_id])
    chat = current_owner.pet.chats.new(chat_params)
    chat.room_id = @room.id
    chat.save
    @room.create_notification_chat(@pet, chat)
    @chats = chat.room.chats
    @chat = Chat.new
  end

  private

  def chat_params
    params.require(:chat).permit(:message)
  end
end
