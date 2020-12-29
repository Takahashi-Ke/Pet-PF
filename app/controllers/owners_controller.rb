class OwnersController < ApplicationController

  def unsubscribe
  end

  def withdraw
    current_owner.destroy
    redirect_to root_path
  end

end
