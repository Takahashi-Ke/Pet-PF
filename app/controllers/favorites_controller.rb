class FavoritesController < ApplicationController

  def create
    pet = current_owner.pet
    @diary = Diary.find(params[:id])
    favorite = pet.favorites.new(diary_id: @diary.id)
    favorite.save
    @diary.create_notification_favo(pet)
  end

  def destroy
    @diary = Diary.find(params[:id])
    pet = current_owner.pet
    favorite = pet.favorites.find_by(diary_id: @diary.id)
    favorite.destroy
  end

end
