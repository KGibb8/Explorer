class ExpeditionsController < ApplicationController

  def index
    if user_signed_in?
      @expeditions = current_user.expeditions
    end
    @most_recent = Expedition.where('complete = true').order('end_time DESC')
    binding.pry
    # @most_popular = Expedition.find_by_sql(
    #   "SELECT DISTINCT * FROM expeditions AS e
    #     INNER JOIN journeys AS j ON j.expedition_id = e.id
    #     ORDER BY COUNT(j.id) DESC;"
    # )
  end

end
