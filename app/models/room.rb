class Room < ApplicationRecord

  has_many :pet_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # チャットがきた時に通知を生成するメソッド
  def create_notification_chat(pet, chat)
    chat_pet = PetRoom.find_by(room_id: id, pet_id: pet.id)
    notification = chat.pet.active_notifications.new(
        room_id: self.id,
        visited_id: chat_pet.pet_id,
        action: 'chat'
        )
    if notification.visitor_id == chat.pet_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end
  
  # 最新メッセージを取得するメソッド
  def now_message(room)
    latest_message = Chat.where(room_id: id).last
    return latest_message
  end
  
end
