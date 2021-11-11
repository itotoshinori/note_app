class LogoutController < ApplicationController
  def logout
    sign_out(:user)
    redirect_to '/'
  end
end
