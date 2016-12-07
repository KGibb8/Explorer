
module ExpeditionHelper

  def self.build_markers(expedition)
    geojson = {}
    geojson["type"] = "FeatureCollection"
    start_point = { longitude: expedition.start_lng, latitude: expedition.start_lat }
    end_point = { longitude: expedition.end_lng, latitude: expedition.end_lat }
    markers = [start_point, end_point].inject([]) do |collection, point|
      collection << geojson_marker(point)
    end
    geojson["features"] = markers
    geojson
  end

  def self.geojson_marker(coordinates)
    marker = {}
    marker["type"] = "Feature"

    geometry = {}
    geometry["type"] = "Point"
    geometry["coordinates"] = [coordinates[:longitude], coordinates[:latitude]]

    marker["geometry"] = geometry
    marker
  end

end
