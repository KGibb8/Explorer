class ExpeditionsController < ApplicationController
  before_action :find_expedition, only: [:show, :update]

  def index
    if user_signed_in?
      @expedition = Expedition.new
      @expeditions = current_user.expeditions
    end
    @most_recent = Expedition.where('complete = true').order('end_time DESC')
    # @most_popular = Expedition.find_by_sql(
    #   "SELECT DISTINCT * FROM expeditions AS e
    #     INNER JOIN journeys AS j ON j.expedition_id = e.id
    #     ORDER BY COUNT(j.id) DESC;"
    # )
  end

  def show
  end

  def create
    expedition = current_user.create_expedition(
      expedition_params[:title],
      expedition_params[:description],
      expedition_params[:start_date],
      expedition_params[:end_date]
    )
    binding.pry
    redirect_to expedition_path(expedition)
  end

  private

  def expedition_params
    params.require(:expedition).permit(:title, :description, :header, :start_time, :end_time, :start_lat, :start_lng, :end_lat, :end_lng)
  end

  def find_expedition
    @expedition = Expedition.find(params[:id])
  end

end
