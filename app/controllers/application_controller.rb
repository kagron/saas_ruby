class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Whitelist the following form fields so that we can process them
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:stripe_card_token, :email, :password, :password_configuration)}
    end
end
