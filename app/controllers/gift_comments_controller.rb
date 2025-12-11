class GiftCommentsController < ApplicationController
  def new
    @gift_comment = GiftComment.new
    @back = params[:back]
    puts @back
  end

  def create
    @save_params = {:user_id => params[:gift_comment][:user_id], :content => params[:gift_comment][:content], :gift_id => params[:gift_comment][:gift_id]}
    @new_gift_comment = GiftComment.new(@save_params)
    @back = params[:gift_comment][:back]
    if @new_gift_comment.save
      flash[:notice] = "New comment saved"
      redirect_to gift_path(params[:gift_comment][:gift_id], back:@back)
    else
      flash[:alert] = "Could not save new comment"
      redirect_to gift_path(params[:gift_comment][:gift_id], back:@back)
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @gift_comment = current_user.gift_comments.find(params[:id])
    @gift_id = @gift_comment.gift.id
    @gift_comment.destroy
    @back = params[:back]
    flash[:notice] = "Comment deleted."
    redirect_to gift_path(@gift_id, back: @back)
  end

  private
  def save_params
    params.require(:gift_comment).permit(:content, :back)
  end
end
