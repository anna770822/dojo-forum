class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:user, :title, :content)
  end
end
