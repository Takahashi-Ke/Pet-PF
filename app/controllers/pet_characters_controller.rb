class PetCharactersController < ApplicationController
  
  def create
    
    @pet = Pet.find(params[:pet_id])
    params[:pet_character].each do |c|
      pet_character = PetCharacter.new(character_params)
      pet_character.pet_id = @pet.id
      pet_character.character_id = c
      pet_character.save
      logger.debug pet_character.errors.inspect
    end
    redirect_to pet_path(@pet)
  end
  
  private
  def character_params
    params.require(:pet_character).permit(character: [name:[]])
  end
  
end
