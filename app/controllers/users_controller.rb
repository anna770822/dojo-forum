class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def comments
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
  end
end
