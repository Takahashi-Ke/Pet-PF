class Chat < ApplicationRecord
  belongs_to :pet
  belongs_to :room

  validates :message, presence: :ture
  
  def message_date(chat)
    today_message = Chat.find_by(room_id: chat.room_id, created_at: Date.today.all_day)
    if chat.id == today_message.id
      return true
    end
  end
  
end
