class Api::MemosController < ApplicationController
  protect_from_forgery except: %i[create update destroy]
  before_action :authenticate_user!
  before_action :unless_current_user
  before_action :user_admin, only: [:create]

  def index
    if params[:description].present?
      description = params[:description]
    else
      description = '%'
    end
    complete = params[:complete]
    twitter = params[:searchTwitter]
    link = params[:searchLink]
    upImportant = params[:upImportant]
    updateAt = params[:updateAt]
    if current_user.present?
      @memos = Memo.where('user_id = ?', current_user.id)
      if description.present?
        @memos = @memos.where('description LIKE ?', "%#{description}%")
      end
      @memos = @memos.where('complete = ?', false) if complete.present?
      @memos = @memos.where('twitter = ?', true) if twitter.present?
      @memos = @memos.where('link <> ?', '') if link.present?
      @memos = @memos.order('important DESC') if upImportant.present?
      if updateAt.present?
        @memos = @memos.order('updated_at DESC')
      else
        @memos = @memos.order('created_at DESC')
      end
    end
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save
      if current_user.id != @user_admin.id
        MemoMailer.creation_email(
          @user_admin.email,
          '新規投稿がありました',
          @memo.description,
          "#{current_user.name}さんから",
        ).deliver_now
      end
      render json: '登録に成功しました', status: 200
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  def update
    @memo = Memo.find_by(id: params[:id], user_id: current_user.id)
    if @memo.update(memo_params)
      render json: '更新に成功しました', status: 200
    else
      render json: '更新に失敗しました', status: 500
    end
  end

  def destroy
    memo = Memo.find_by(id: params[:id], user_id: current_user.id)
    if memo.destroy
      render json: {
               status: 'SUCCESS',
               message: 'Deleted the post',
               data: @memo,
             }
    else
      render json: '削除に失敗しました', status: 500
    end
  end

  private

  def memo_params
    params.permit(
      :title,
      :description,
      :id,
      :link,
      :important,
      :complete,
      :twitter,
      :public,
    )
  end
end
