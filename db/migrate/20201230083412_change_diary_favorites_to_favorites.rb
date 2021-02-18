class ChangeDiaryFavoritesToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_table :diary_favorites, :favorites
    add_column :favorites, :memory_id, :integer
  end
end
