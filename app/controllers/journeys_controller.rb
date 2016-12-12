class JourneysController < ApplicationController
  before_action :find_expedition, only: [:inviting, :requesting, :approve, :accepting]

  def inviting
    users = journeys_params[:user_ids][1..-1].inject([]) do |array, user_id|
      user = User.find(user_id)
      @expedition.invite(user)
      array << user
    end
    flash[:notice] = "Invited #{users.count} friends to #{@expedition.name}"
    redirect_to expedition_path(@expedition)
  end

  def requesting
    request = @expedition.request(current_user)
    flash[:notice] = request.status = "requested" ? "Request sent" : "Request failed"
    redirect_to expedition_path(@expedition)
  end

  def approve
    if @expedition.creator? current_user
      @expedition.permit_attendance(journey_params[:user_id])
      flash[:notice] = "Approved"
    end
    redirect_to expedition_path(@expedition)
  end

  def accepting
    if @expedition.invited? current_user
      current_user.accept_invite(@expedition)
      flash[:notice] = "Invite Accepted"
    end
    redirect_to expedition_path(@expedition)
  end

  private

  def find_expedition
    @expedition = Expedition.find(params[:expedition_id])
  end

  def journeys_params
    params.require(:journeys).permit(user_ids: [])
  end

  def journey_params
    params.require(:journey).permit(:user_id)
  end

end
