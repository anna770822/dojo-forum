class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def comments
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
  end

  def drafts
    @user = User.find(params[:id])
    @drafts = Post.where(public: false)

  end

  def friends
    @not_yet_accepted_friendships = Friendship.where(user_id: current_user.id, status: false)
    @not_yet_responded_friendships = Friendship.where(friend_id: current_user.id, status: false)
    @user = User.find(params[:id])
    @friends = @user.all_friends
  end
end
