class ApplicationController < ActionController::Base
	protect_from_forgery
	before_action :configure_permitted_parameters, if: :devise_controller?
	def user_set
    @user = current_user
    if @user.blank?
      flash[:warning] = "閲覧権限がありません"
      redirect_to poems_path
    end 
  end
	protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
