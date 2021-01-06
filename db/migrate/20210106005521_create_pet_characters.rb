class CreatePetCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_characters do |t|
      t.references :pet
      t.references :character

      t.timestamps
    end
  end
end
