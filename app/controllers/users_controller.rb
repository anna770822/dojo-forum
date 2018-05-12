class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = Post.where(user_id: @user.id).order(updated_at: :desc)
  end

  def comments
 
    @comments = Comment.where(user_id: @user.id).order(updated_at: :desc)
  end

  def drafts
   
    @drafts = Post.where(public: false).order(updated_at: :desc)
  end

  def friends
    @not_yet_accepted_friendships = Friendship.where(user_id: current_user.id, status: false)
    @not_yet_responded_friendships = Friendship.where(friend_id: current_user.id, status: false)

    @friends = @user.all_friends
  end

  def collects
   
    @collections = @user.collections.order(updated_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
