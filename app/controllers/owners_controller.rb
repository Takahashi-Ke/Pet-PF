class OwnersController < ApplicationController
  before_action :check_guest, only: :destroy

  def unsubscribe
  end

  def destroy
    current_owner.destroy
    redirect_to root_path
  end

  def check_guest
    if current_owner.email == 'guest@example.com'
      flash.now[:alert] = 'ゲストは退会できません'
      render :unsubscribe
      
    end
  end

end
