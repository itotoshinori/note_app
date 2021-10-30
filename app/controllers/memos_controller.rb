class MemosController < ApplicationController
  def show
    @memos = Memo.where("public = ?", true)
    @memo = @memo.find(params[:id]) if @memos.present?
    render :layout => nil
  end
end
