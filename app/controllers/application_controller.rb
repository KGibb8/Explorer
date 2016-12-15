class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :new_expedition
  before_action :friend_requests

  protected

  def new_expedition
    @new_expedition = Expedition.new
  end

  def friend_requests
    @friend_requests = current_user ? current_user.friend_requests.paginate(page: params[:page], per_page: 10) : []
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
