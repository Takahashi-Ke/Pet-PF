class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name,:image, :is_deleted,
                                      pet_attributes: [:id, :name, :image, :birthday, :gender, :type, :introduction, :_destroy]
                                      ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :is_deleted])
  end

end
