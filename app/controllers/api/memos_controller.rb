class Api::MemosController < ApplicationController
  protect_from_forgery except: [:create, :update]

	def index
    if params[:description].present?
      description = params[:description]
    else
      description = "%"
    end
    complete = params[:complete]
    twitter = params[:searchTwitter]

    upImportant = params[:upImportant]
    #debugger
    if current_user.present?
      if description.present?
        @memos = Memo.where("description LIKE ?", "%#{description}%")
      end
      if complete.present?
        @memos = @memos.where("complete = ?", false)
      end
      if twitter.present?
        @memos = @memos.where("twitter = ?", true)
      end
      if upImportant.present?
        #@memos = @memos.where("important = ?", true)
        @memos = @memos.order('important DESC').order('created_at DESC')
      else
        @memos = @memos.order('created_at DESC')
      end
    end
  end
	
	def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save
      render :show, status: :created
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      render json: '更新に成功しました', status: 200
    else
      render json: '更新に失敗しました', status: 500
    end
  end

  def destroy
    memo = Memo.find(params[:id])
    if memo.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the post', data: @memo }
    else
      render json: '削除に失敗しました', status: 500
    end
  end
 
  private
    def memo_params
      params.permit(:title,:description,:id,:link,:important,:complete,:twitter,:public)
    end
end
