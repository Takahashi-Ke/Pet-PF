class PetPersonality < ActiveRecord::Migration[5.2]
  def change
    drop_table :pet_personalities
  end
end
