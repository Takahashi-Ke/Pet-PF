class DiaryFavoritesController < ApplicationController

  def create
    @diary = Diary.find(params[:id])
    pet = current_owner.pet
    favorite = pet.diary_favorites.new(diary_id: @diary.id)
    favorite.save
    @diary.create_notification_favo(pet)
  end

  def destroy
    @diary = Diary.find(params[:id])
    pet = current_owner.pet
    favorite = pet.diary_favorites.find_by(diary_id: @diary.id)
    favorite.destroy
  end

end
