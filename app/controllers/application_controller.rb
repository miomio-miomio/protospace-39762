class ApplicationController < ActionController::Base
  before_action :configure_permit_parameters, if: :devise_controller?

  private

  def configure_permit_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password, :name ,:profile, :occupation, :position])
  end

end
