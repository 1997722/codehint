class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    return unless @comment.save

    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
