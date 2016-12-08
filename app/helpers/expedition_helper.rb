module ExpeditionHelper

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
