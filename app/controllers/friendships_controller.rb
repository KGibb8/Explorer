class FriendshipsController < ApplicationController

  def create
    user = User.find(friendships_params[:friend_id])
    current_user.befriend(user)
    render json: { success: true, message: "Request Sent" }
  end

  def accept_friend
    user = User.find(friendships_params[:user_id])
    current_user.accept_friend(user)
    render json: { success: true, message: "Friend Accepted", user: user, profile: user.profile }
  end

  def reject_friend

  end

  private

  def friendships_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

end
