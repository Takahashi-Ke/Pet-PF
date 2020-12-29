class CreatePetPersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_personalities do |t|
      t.references :pet
      t.integer :personality

      t.timestamps
    end
  end
end
