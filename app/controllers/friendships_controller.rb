class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.not_yet_accepted_friendships.build(friend_id: params[:friend_id])
    @friendship.save
    redirect_to friends_user_path(current_user)
  end

  def accept
    @friendship = Friendship.find(params[:id])
    @friendship.update(status: true)
    redirect_to friends_user_path(current_user)
  end

  def ignore
    @friendship = Friendship.find(params[:id])
    @friendship.update(status: nil)
    redirect_to friends_user_path(current_user)
  end
end
