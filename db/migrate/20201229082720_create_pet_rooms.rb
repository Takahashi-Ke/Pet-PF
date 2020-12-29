class CreatePetRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_rooms do |t|
      t.references :pet
      t.references :room

      t.timestamps
    end
  end
end
