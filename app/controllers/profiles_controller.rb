class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :update]

  def show

  end

  def update
    @profile.update(profile_params)
    render json: @profile
  end

  private

  def find_profile
    @profile = User.find(params[:user_id]).profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :biography, :avatar)
  end

end
