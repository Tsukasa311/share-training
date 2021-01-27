class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
