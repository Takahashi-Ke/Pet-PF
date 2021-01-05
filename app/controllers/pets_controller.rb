class PetsController < ApplicationController

  def show
    @pet = Pet.find(params[:id])
    @pet_personalities = @pet.pet_personalities
    @memories = @pet.memories
    @diaries = @pet.diaries
    @photos  = Diary.where.not(image_id: nil).where(pet_id: @pet)
    @diary = Diary.new
    @diary_comment = DiaryComment.new
    @pet.pet_personalities.build
  end

  def edit
    @pet = Pet.find(params[:id])
    @pet.pet_personalities.build
  end

  def update
    pet = Pet.find(params[:id])
    
    params[:owner][:pet_attributes][:pet_personalities_attributes].each do |k, v|
       pet_personality = pet.pet_personality
       pet_personality.personality = v[:personality].to_i
       current_owner.update(owner_pet_params)
    end
    redirect_to pet_path(pet)
  end

  private
  def owner_pet_params
    params.require(:owner).permit(:name, :image, pet_attributes: [:id, :name, :image, :birthday, :gender, :type, :introduction, :_destroy,
                                      pet_personalities_attributes: [:id, :personality, :_destroy]])
  end

end
