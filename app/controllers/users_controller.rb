class UsersController < ApplicationController
  #protect_from_forgery except: [:create, :update, :destroy]
  #before_action :authenticate_user!
  before_action :user_admin

  def index
    @users = User.all.order('created_at ASC')
  end

  def ajax_update
    @user = User.find(params[:data])
    pass_code = params[:passcode]
    @user.password = "password"
    if @user.save and pass_code == "7a3T67q"
      @message = "ユーザー#{@user.id}のパスワードを『password』に設定しました"
    else
      @message = "パスワードの初期化に失敗しました"
    end
  end
  def ajax_delete
    @user = User.find(params[:data])
    pass_code = params[:passcode]
    user_id = @user.id
    if @user.destroy and pass_code == "4rtbW23lT2"
      @message = "ユーザー#{@user_id}が削除されました。更新後のデータを確認するには上記　一覧をクリックして下さい"
    else
      @message = "削除失敗しました"
    end
  end
end
