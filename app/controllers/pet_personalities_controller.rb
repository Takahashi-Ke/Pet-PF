class PetPersonalitiesController < ApplicationController
  def create
    pet = current_owner.pet
    unless params[:pet].nil?
      params[:pet][:pet_personalities_attributes].each do |_k, v|
        pet_personality = pet.pet_personalities.new(personality_params)
        pet_personality.personality = v[:personality].to_i
        pet_personality.save
      end
    end
    redirect_to request.referer
  end

  private

  def personality_params
    params.require(:pet).permit(pet_personalities: %i[personality _destroy])
  end
end
