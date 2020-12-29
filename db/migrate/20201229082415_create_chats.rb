class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :pet
      t.references :room
      t.references :roomt
      t.string :message

      t.timestamps
    end
  end
end
