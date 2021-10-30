class MemosController < ApplicationController
  def show
    @memo = Memo.where("public = ?", true)
    @memo = @memo.find(params[:id])
    render :layout => nil
  end
end
