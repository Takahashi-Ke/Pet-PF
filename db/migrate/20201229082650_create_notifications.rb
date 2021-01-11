class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :diary
      t.references :memory
      t.references :room
      t.references :visitor
      t.references :visited
      t.references :diary_comment
      t.references :memory_comment
      t.string :action
      t.boolean :is_checked , default: false, null: false
      
      t.timestamps
    end
  end
end
