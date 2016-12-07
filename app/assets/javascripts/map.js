var geojson
function locate () {
  var geo = navigator.geolocation;
  if (geo) {
    geo.getCurrentPosition(function (position) {
      map.setCenter([position.coords.longitude, position.coords.latitude]);
    }, function (error) {
      console.log("Error");
    });
  }
};

function initMap () {
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/satellite-v9',
    zoom: 8
  });
  map.addControl(new mapboxgl.GeolocateControl());
  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken
  }), "top-left");
  return map;
}

