class Api::UsersController < ApplicationController
  def index
    @users = User.where(id:current_user.id)
  end
  def show
    @user = User.find(current_user.id)
  end
end
