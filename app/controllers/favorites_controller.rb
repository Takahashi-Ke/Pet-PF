class FavoritesController < ApplicationController

  def create
    pet = current_owner.pet
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "diaries" || path[:controller] == "pets"
      @diary = Diary.find(params[:id])
      favorite = pet.favorites.new(diary_id: @diary.id)
      favorite.save
      @diary.create_notification_favo(pet)
    else
      @memory = Memory.find(params[:id])
      favorite = pet.favorites.new(memory_id: @memory.id)
      favorite.save
      redirect_to request.referer
    end
  end

  def destroy
    pet = current_owner.pet
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "diaries" || path[:controller] == "pets"
      @diary = Diary.find(params[:id])
      favorite = pet.favorites.find_by(diary_id: @diary.id)
    else
      @memory = Memory.find(params[:id])
      favorite = pet.favorites.find_by(memory_id: @memory.id)
      redirect_to request.referer
    end
    favorite.destroy
  end

end
