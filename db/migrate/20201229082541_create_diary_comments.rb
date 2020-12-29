class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments do |t|
      t.references :pet
      t.references :diary
      t.string :comment

      t.timestamps
    end
  end
end
