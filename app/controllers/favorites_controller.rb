class FavoritesController < ApplicationController
  def index
    @diary = Diary.new
    @pet = current_owner.pet
  end

  def create
    pet = current_owner.pet
    if params[:memory_id].present?
      @diary = Diary.new
      @memory = Memory.find(params[:id])
      favorite = pet.favorites.new(memory_id: @memory.id)
      favorite.save
      @memory.create_notification_favo(pet)
    else
      @diary = Diary.find(params[:id])
      favorite = pet.favorites.new(diary_id: @diary.id)
      favorite.save
      @diary.create_notification_favo(pet)

    end
  end

  def destroy
    pet = current_owner.pet
    if params[:memory_id].present?
      @diary = Diary.new
      @memory = Memory.find(params[:id])
      favorite = pet.favorites.find_by(memory_id: @memory.id)
    else
      @diary = Diary.find(params[:id])
      favorite = pet.favorites.find_by(diary_id: @diary.id)
    end
    favorite.destroy
  end
end
