class JourneysController < ApplicationController
  before_action :find_expedition, only: [:requesting, :approve]

  def requesting
    request = @expedition.request(current_user)
    request.status = "requested" ? flash[:notice] = "Request sent" : flash[:notice] = "Request failed"
    redirect_to expedition_path(@expedition)
  end

  def approve
    if @expedition.creator? current_user
      @expedition.permit_attendance(journey_params[:user_id])
      flash[:notice] = "Approved"
    end
    redirect_to expedition_path(@expedition)
  end

  private

  def find_expedition
    @expedition = Expedition.find(journey_params[:expedition_id])
  end

  def journey_params
    params.require(:journey).permit(:user_id, :expedition_id)
  end

end
