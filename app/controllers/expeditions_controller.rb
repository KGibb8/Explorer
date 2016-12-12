class ExpeditionsController < ApplicationController
  include ExpeditionHelper

  before_action :find_expedition, only: [:show, :update, :markers]
  respond_to :json

  def index
    if current_user
      @expedition_activities = current_user.expedition_activities
      @expedition = Expedition.new
      @expeditions = current_user.expeditions
    end
    @most_recent = Expedition.recent
    # @most_popular = Expedition.find_by_sql(
    #   "SELECT DISTINCT * FROM expeditions AS e
    #     INNER JOIN journeys AS j ON j.expedition_id = e.id
    #     ORDER BY COUNT(j.id) DESC;"
    # )
  end

  def create
    expedition = current_user.create_expedition(expedition_params)
    redirect_to expedition_path(expedition)
  end

  def show
    @attending_users = @expedition.attending_users.paginate(page: params[:friends_page], per_page: 9)
    @invited_users = @expedition.invited_users.paginate(page: params[:friends_page], per_page: 9)
    @requested_users = @expedition.requested_users if @expedition.creator? current_user
    @attended_users = @expedition.attended_users if @expedition.complete?
    @start_location = @expedition.start_location
    @end_location = @expedition.end_location
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
      :title, :description, :header, :start_time, :end_time, :start_lat, :start_lng, :end_lat, :end_lng,
      start_locations_attributes: [:latitude, :longitude, :location, :start_location], end_locations_attributes: [:latitude, :longitude, :location, :end_location]
    )
  end

  def find_expedition
    @expedition = Expedition.find(params[:id])
  end

end
