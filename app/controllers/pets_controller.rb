class PetsController < ApplicationController

  def show
    @pet = Pet.find(params[:id])
    @pet_personalities = @pet.pet_personalities
    @pet.pet_personalities.build
    @memories = @pet.memories
    @diaries = @pet.diaries
    @photos  = Diary.where.not(image_id: nil).where(pet_id: @pet)
    @diary = Diary.new
    @diary_comment = DiaryComment.new
  end

  def edit
    @pet = Pet.find(params[:id])
    #@pet.pet_personalities.build
    @owner = @pet.owner
  end

  def update
    pet = Pet.find(params[:id])
    pet.pet_personalities.destroy_all
    params[:owner][:pet_attributes][:pet_personalities].each do |pp|
      PetPersonality.personalities.map do |k,v|
        if v == pp.to_i
          pet_personality = pet.pet_personalities.new(personality_params)
          pet_personality.personality = pp.to_i
          pet_personality.save
        end
      end
    end
    current_owner.update(owner_pet_params)
    redirect_to pet_path(pet)
  end

  private
  def owner_pet_params
    params.require(:owner).permit(:name, :image, pet_attributes: [:id, :name, :image, :birthday, :gender, :type, :introduction, :_destroy,
                                      ])
  end
  def personality_params
    params.permit(:personality)
  end

end
