class AddColumnMemory < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :memory_id, :string
    add_column :notifications, :memory_comment_id, :string
  end
end
