class CreatePetCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_characters do |t|
      t.references :pet, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
