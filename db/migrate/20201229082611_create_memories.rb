class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.references :pet
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
