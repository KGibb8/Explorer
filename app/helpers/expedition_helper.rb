module ExpeditionHelper

  def organiser
    current_user && @expedition.creator?(current_user)
  end

  def requestable
    @expedition.invited_users.exclude?(current_user) && @expedition.requested_users.exclude?(current_user) && @expedition.attending_users.exclude?(current_user) && @expedition.rejected_users.exclude?(current_user)
  end

  def involved
    @expedition.attending?(current_user) || @expedition.invited?(current_user) || @expedition.attended?(current_user)
  end

  def self.build_markers(expedition)
    geojson = {}
    geojson["type"] = "FeatureCollection"
    markers = [expedition.start_location, expedition.end_location].inject([]) do |collection, coordinate|
      collection << geojson_marker(coordinate)
    end
    geojson["features"] = markers
    geojson
  end

  def self.geojson_marker(coordinate)
    marker = {}
    marker["type"] = "Feature"

    geometry = {}
    geometry["type"] = "Point"
    geometry["coordinates"] = [coordinate.longitude, coordinate.latitude]

    marker["geometry"] = geometry
    marker
  end

end
