class UsersController < ApplicationController
  before_action :set_user, except: :new

  def new
  end

  def show
    # @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    unless current_user.id == @user.id
      redirect_to action: :show,id: @user.id
    end
    # @user = User.find(params[:id])
    @profile = @user.profile
  end

  def update
    # @user = User.find(params[:id])
    @profile = @user.profile
    @profile.update(user_params)
    if @profile.valid?
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:profile).permit(:experience_id, :part_id, :frequency_id, :introduction, :image)
  end
end
