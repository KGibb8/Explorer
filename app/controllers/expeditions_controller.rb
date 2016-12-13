class ExpeditionsController < ApplicationController
  include ExpeditionHelper

  before_action :find_expedition, only: [:show, :update, :markers]
  respond_to :json

  def index
    if current_user
      @activities = current_user.related_activities
      @expedition = Expedition.new
      @expeditions = current_user.expeditions
    end
    @most_recent = Expedition.recent
  end

  def create
    expedition = current_user.create_expedition(expedition_params)
    redirect_to expedition_path(expedition)
  end

  def show
    @attending_users = @expedition.attending_users.paginate(page: params[:attending_page], per_page: 9)
    @invited_users = @expedition.invited_users.paginate(page: params[:invited_page], per_page: 9)
    @requested_users = @expedition.requested_users.paginate(page: params[:requesting_page], per_page: 9) if organiser
    @attended_users = @expedition.attended_users.paginate(page: params[:attended_page], per_page: 9) if @expedition.complete?
    @start_location = @expedition.start_location
    @end_location = @expedition.end_location
    @chats = @expedition.chats
    @chat = Chat.new
  end

  def update
    @expedition.update(expedition_params)
    render json: @expedition
  end

  def markers
    respond_to do |format|
      format.json do
        render json: ExpeditionHelper.build_markers(@expedition)
      end
    end
  end

  private

  def expedition_params
    params.require(:expedition).permit(
      :name, :description, :header, :start_time, :end_time, :start_lat, :start_lng, :end_lat, :end_lng,
      start_locations_attributes: [:latitude, :longitude, :location, :start_location], end_locations_attributes: [:latitude, :longitude, :location, :end_location]
    )
  end

  def find_expedition
    @expedition = Expedition.find(params[:id])
  end

end
