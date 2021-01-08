class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_owner!,except: [:top, :about]
  
  
  def after_sign_in_path_for(resources)
    pet_path(current_owner.pet)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name,:image,
                                      pet_attributes: [:id, :name, :image, :birthday, :gender, :type, :introduction, :_destroy]
                                      ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end

end
