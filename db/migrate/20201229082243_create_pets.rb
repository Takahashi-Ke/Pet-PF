class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.references :owner
      t.string :name, null: false
      t.string :image_id
      t.date :birthday, null: false
      t.integer :gender, null: false
      t.text :introduction
      t.integer :type, null: false

      t.timestamps
    end
  end
end
