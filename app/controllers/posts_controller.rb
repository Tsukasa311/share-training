class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :search, :create, :update, :destroy]
  before_action :set_post, only: [:show, :destroy]
  before_action :search_post, only: [:home, :search]

  def home
    @posts = Post.includes(:user)
  end

  def search
    @results = @p.result.includes(:user, :likes).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      flash[:notice] = "投稿が完了しました！"
      redirect_to controller: :users, action: :show, id: @post.user_id
    else
      render :new
    end
  end

  def show
  end

  def destroy
    redirect_to root_path and return unless current_user.id == @post.user_id

    if @post.destroy
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

# def tag_search
#   return nil if params[:keyword] == ''

#   tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
#   render json: { keyword: tag }
# end
