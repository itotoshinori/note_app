class Api::InfosController < ApplicationController
  protect_from_forgery except: %i[update]
  before_action :unless_current_user
  def show
    @info = Info.includes(:user).find_by(user_id: current_user.id)
    #@info = Info.find_by(user_id:current_user.id)
  end

  def update
    @info = Info.find(params[:id])
    @info.twitter_tag.gsub("　", '　#') if @info.twitter_tag.include("　")
    if @info.update(info_params)
      render json: '更新に成功しました', status: 200
    else
      render json: '更新に失敗しました', status: 500
    end
  end

  private

  def info_params
    params.permit(:twitter_tag, :user_id)
  end
end
