class PostsController < ApplicationController
  before_action :authenticate_user!, except: :home
  before_action :set_post, only: [:show, :destroy]
  before_action :search_post, only: [:home, :search]

  def home
  end

  def search
    @results = @p.result.includes(:comments,:likes, :liked_users,user: :profile).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      flash[:post_notice] = "投稿が完了しました！"
      redirect_to controller: :users, action: :show, id: @post.user_id
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(user: :profile)
  end

  def destroy
    redirect_to root_path and return unless current_user.id == @post.user_id
    if @post.destroy
      flash[:post_notice] = "投稿を削除しました！"
      redirect_to controller: :users, action: :show, id: @post.user_id
    else
      render :show
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:text, :part_id, :equipment_id, :place_id, :start_time).merge(user_id: current_user.id)
  end

  def search_post
    @p = Post.ransack(params[:q])
  end
end
