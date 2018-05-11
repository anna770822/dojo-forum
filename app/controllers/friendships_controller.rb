class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.not_yet_accepted_friendships.build(friend_id: params[:friend_id])
    @friendship.save
    redirect_to friends_user_path(current_user)
  end

  def accept
    @friendship = Friendship.where(user_id: params[:user_id],friend_id:current_user.id)
    @friendship.update(status: true)
    redirect_to friends_user_path(current_user)
  end

  def ignore
    @friendship = Friendship.where(user_id: params[:user_id],friend_id:current_user.id)
    @friendship.destroy_all
    redirect_to friends_user_path(current_user)
  end
end
