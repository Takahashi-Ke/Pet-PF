class RemoveRoomtFromChats < ActiveRecord::Migration[5.2]
  def change
    remove_reference :chats, :roomt, foreign_key: true
  end
end
