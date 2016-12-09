class ProfilesController < ApplicationController
  include ProfileHelper

  before_action :find_profile, only: [:show]

  def show
    @friend_requests = my_profile ? current_user.friend_requests.paginate(page: params[:page], per_page: 10) : []
    @friends = @profile.user.friends.paginate(page: params[:friends_page], per_page: 9)
    @future_expeditions = @profile.user.attending_expeditions.paginate(page: params[:future_expeds_page], per_page: 5)
    @past_expeditions = @profile.user.attended_expeditions.paginate(page: params[:past_expeds_page], per_page: 5)
  end

  def update
    current_user.profile.update(profile_params)
    render json: current_user.profile
  end

  private

  def find_profile
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :biography, :avatar)
  end

end
