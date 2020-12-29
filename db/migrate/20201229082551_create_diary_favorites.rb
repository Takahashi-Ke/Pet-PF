class CreateDiaryFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_favorites do |t|
      t.references :pet
      t.references :diary

      t.timestamps
    end
  end
end
