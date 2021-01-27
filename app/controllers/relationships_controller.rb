class RelationshipsController < ApplicationController
  def create
    current_owner.pet.follow(params[:pet_id])
    pet = Pet.find_by(id: params[:pet_id])
    pet.create_notification_follow(current_owner.pet)
    redirect_to request.referer
  end

  def destroy
    current_owner.pet.unfollow(params[:pet_id])
    redirect_to request.referer
  end
end
