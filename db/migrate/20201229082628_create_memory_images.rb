class CreateMemoryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_images do |t|
      t.references :memory
      t.string :image_id

      t.timestamps
    end
  end
end
