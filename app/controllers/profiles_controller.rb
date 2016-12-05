class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show]

  def show

  end

  private

  def find_profile
    @profile = User.find(params[:user_id]).profile
  end

end
