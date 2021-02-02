class UsersController < ApplicationController
  before_action :set_user, except: :new
  before_action :authenticate_user!, only: [:show, :edit, :update]
  
  def new
  end

  def show
    @posts = @user.posts.includes(:comments, :likes, :liked_users).order(created_at: :desc)
    @array = part_count
  end

  def edit
    redirect_to action: :show,id: @user.id and return unless current_user.id == @user.id
    @profile = @user.profile
  end

  def update
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

  def part_count
    array = []
    @posts.each do |post|
      part_id = post.part_id
      array << part_id
    end
    array
  end
end
