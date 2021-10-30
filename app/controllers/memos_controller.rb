class MemosController < ApplicationController
  def show
    @memos = Memo.where("public = ?", true)
    @memo = @memos.find(params[:id]) if @memos.present?
    render :layout => nil
  end
end
