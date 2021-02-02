class CommentsController < ApplicationController
  before_action :set_post_comments
  
  def create
    @comment = Comment.create(comment_params)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end

  def set_post_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user)
  end
end
