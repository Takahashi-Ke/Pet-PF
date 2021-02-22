class RelationshipsController < ApplicationController
  def create
    current_owner.pet.follow(params[:pet_id])
    @pet = Pet.find(params[:pet_id])
    @pet.create_notification_follow(current_owner.pet)
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    current_owner.pet.unfollow(@pet.id)
  end
end
