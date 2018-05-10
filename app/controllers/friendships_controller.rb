class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.not_yet_accepted_friendships.build(friend_id: params[:friend_id])
    @friendship.save

  end
end
