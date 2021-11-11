class UsersController < ApplicationController
  #protect_from_forgery except: [:create, :update, :destroy]
  #before_action :authenticate_user!
  before_action :user_admin

  def index
    if current_user.present?
      if current_user.id == user_admin.id
        @users = User.all.order('created_at ASC')
      else
        redirect_to "/"
      end
    else
      redirect_to new_user_session_path
    end
  end
  #ユーザー側のパスワードリセットはこちら
  def password_reset
    email = params[:email]
    user = User.find_by(email:email)
    if user.nil?
      @message = "このメールアドレスでの登録がないかメールアドレスの入力されていません。"
    else
      result = Reset.new(user.email)
      new_password = result.new_password
      if result
        MemoMailer.creation_email(user.email,"メモシステムのパスワードを再設定をしました。","新しいパワードは #{new_password}　です。編集のリンクからご自分のパスワードに変更をお願いします。","").deliver_now
        @message = "このメールアドレスに再設定のパスワードを送信しました。迷惑メールも含めご確認頂き、届かなければ管理人にお問合せ下さい"
      else
        @message = "送信に失敗しました"
      end
    end
  end

  def ajax_update
    if params[:passcode] == "7a3T67q"
      user = User.find(params[:data])
      result = Reset.new(user.email)
      new_password = result.new_password
      if result
        MemoMailer.creation_email(current_user.email,"メモシステムのパスワードを再設定をしました。","新しいパワードは #{new_password}　です。編集のリンクからご自分のパスワードに変更をお願いします。","").deliver_now
        @message = "ユーザー#{user.id}のパスワードを再設定し、ユーザーに通知メールを送りました"
      else
        @message = "パスワードの初期化に失敗しました"
      end
    end
  end

  def ajax_delete
    @user = User.find(params[:data])
    pass_code = params[:passcode]
    user_id = @user.id
    if @user.destroy and pass_code == "4rtbW23lT2"
      @message = "ユーザー#{@user_id}が削除されました。更新後のデータを確認するには上記　一覧をクリックして下さい"
    else
      @message = "削除に失敗しました"
    end
  end
end
