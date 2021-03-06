class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  def user_set
    @now_user = current_user
  end
  def user_admin
    @user_admin = User.first
  end
  def unless_current_user
    redirect_to user_session_path if current_user.blank?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
