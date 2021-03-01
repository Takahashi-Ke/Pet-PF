class PetPersonalitiesController < ApplicationController

  def create
    pet = current_owner.pet
    params[:pet][:pet_personalities_attributes].each do |k, v|
      pet_personality = pet.pet_personalities.new(personality_params)
      pet_personality.personality = v[:personality].to_i
      pet_personality.save
    end
    redirect_to pet_path(pet)
  end

  def update
    pet_personalities = PetPersonality.find_by(pet_id: params[:id])
    pet_personalities.update(personality_params)
    redirect_to request.referer
  end

  private
  def personality_params
    params.require(:pet).permit(pet_personalities: [:personality, :_destroy])
  end
end
