class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show]

  def show
    @attending_expeditions = @profile.user.attending_expeditions
    @attended_expeditions = @profile.user.attended_expeditions
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
