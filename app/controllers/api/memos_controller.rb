class Api::MemosController < ApplicationController
  protect_from_forgery except: [:create, :update]
	def index
    @memos = Memo.order('created_at DESC')
  end
	
	def create
    @memo = Memo.new(memo_params)
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
    memo.destroy
  end
 
  private
    def memo_params
      params.permit(:title, :description,:id)
    end
end
