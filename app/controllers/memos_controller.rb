class MemosController < ApplicationController
  def show
    @memo = Memo.find_by(id:params[:id],public:true)
    render :layout => nil
  end
end
