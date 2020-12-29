class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.references :pet
      t.text :body
      t.string :image_id

      t.timestamps
    end
  end
end
