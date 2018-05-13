class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.not_yet_accepted_friendships.build(friend_id: params[:friend_id])
    if @friendship.save
     redirect_to friends_user_path(current_user)
    else
      redirect_to friends_user_path(current_user)
      flash[:alert]= @friendship.errors.full_messages.to_sentence
    end
  end

  def accept
    @friendship = Friendship.where(user_id: params[:user_id],friend_id:current_user.id)
    @friendship.update(status: true)
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def ignore
    @friendship = Friendship.where(user_id: params[:user_id],friend_id:current_user.id)
    @friendship.destroy_all
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end
end
