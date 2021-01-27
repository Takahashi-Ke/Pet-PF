class Room < ApplicationRecord
  has_many :pet_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # チャットがきた時に通知を生成するメソッド
  def create_notification_chat(pet, chat)
    notification_room = Notification.find_by(room_id: id)
    if notification_room.present?
      notification_room.update(created_at: DateTime.now, is_checked: false)
    else
      notification = chat.pet.active_notifications.new(
        room_id: id,
        visited_id: pet.id,
        action: 'chat'
      )
      notification.save if notification.valid?
    end
  end
end
