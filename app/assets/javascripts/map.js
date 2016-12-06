

var coordinates;
function geocode () {
  var geo = navigator.geolocation;
  if (geo) {
    geo.getCurrentPosition(function (data) {
      coordinates = {
        longitude: data.coords.longitude,
        latitude: data.coords.latitude
      }
    });
  }
};

function renderMap () {
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/satellite-v9',
    zoom: 4
  });
  map.addControl(new mapboxgl.GeolocateControl());
  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken
  }), "top-left");
  return map;
}

