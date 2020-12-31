class CreateMemoryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_comments do |t|
      t.references :pet
      t.references :memory
      t.string :comment
      
      t.timestamps
    end
  end
end
