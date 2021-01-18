class OwnersController < ApplicationController
  before_action :check_guest, only: :unsubscribe

  def unsubscribe
  end

  def destroy
    current_owner.destroy
    redirect_to root_path
  end

  def check_guest
    if current_owner.email == 'guest@example.com'
      @owner = current_owner
      @pet = @owner.pet
      flash.now[:alert] = 'ゲストは退会できません'
      render 'pets/edit'
    end
  end

end
