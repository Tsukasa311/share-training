class PostsController < ApplicationController

  def home
  end

  def index
  end

  def new
    @post = Post.new
  end
end
