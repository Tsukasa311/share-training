class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post, only: [:show,:destroy]

  def home
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def tag_search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    unless current_user.id == @post.user_id
      redirect_to root_path and return
    end
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:text, :part_id, :equipment_id, :place_id).merge(user_id: current_user.id)
  end
end
