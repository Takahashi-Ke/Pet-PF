class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_owner!, except: %i[top about]

  def after_sign_in_path_for(_resources)
    pet_path(current_owner.pet)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name, :image,
                                             { pet_attributes: %i[id name image birthday gender type introduction _destroy] }])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image])
  end
end
