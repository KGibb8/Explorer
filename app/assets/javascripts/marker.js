
var isDragging1;
var isDragging2;

var isCursorOverPoint1;
var isCursorOverPoint2;

var coordinates = document.getElementById('coordinates');

var canvas = map.getCanvasContainer();

// %%TODO%% Here we want to place our own geojson based on current location or previously entered details for the locations
// %%TODO%% Worth having the geojson in a separate script or directly on the page in a script tag
// %%TODO%% A set of geojson for each marker

var geojson = {
  "type": "FeatureCollection",
  "features": [{
    "type": "Feature",
    "geometry": {
      "type": "Point",
      "coordinates": [0, 0]
    }
  }]
};

function mouseDown() {
  if (!isCursorOverPoint1 && !isCursorOverPoint2) return;

  if (isCursorOverPoint1) {
    isDragging1 = true;
  } else if (isCursorOverPoint2) {
    isDragging2 = true;
  };
  canvas.style.cursor = 'grab';
  map.on('mousemove', onMove);
  map.on('mouseup', onUp);
}

function onMove(e) {
  if (!isDragging1 && !isDragging2) return;
  canvas.style.cursor = 'grabbing';
  var coords = e.lngLat;
  geojson.features[0].geometry.coordinates = [coords.lng, coords.lat];
  if (isDragging1) {
    map.getSource('point-1').setData(geojson);
    $('#expedition_start_lat').val(coords.lat);
    $('#expedition_start_lng').val(coords.lng);
  } else if (isDragging2) {
    map.getSource('point-2').setData(geojson);
    $('#expedition_end_lat').val(coords.lat);
    $('#expedition_end_lng').val(coords.lng);
  };
}

function onUp(e) {
  if (!isDragging1 && !isDragging2) return;
  var coords = e.lngLat;
  canvas.style.cursor = '';
  if (isDragging1) {
    isDragging1 = false;
  } else if (isDragging2) {
    isDragging2 = false;
  };
}

map.on('load', function() {

  map.addSource('point-1', {
    "type": "geojson",
    "data": geojson
  });

  map.addSource('point-2', {
    "type": "geojson",
    "data": geojson
  });

  map.addLayer({
    "id": "point-1",
    "type": "circle",
    "source": "point-1",
    "paint": {
      "circle-radius": 10,
      "circle-color": "#3887be"
    }
  });

  map.addLayer({
    "id": "point-2",
    "type": "circle",
    "source": "point-2",
    "paint": {
      "circle-radius": 10,
      "circle-color": "red"
    }
  });

  map.on('mousemove', function(e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['point-1', 'point-2'] });
    if (features.length) {
      var id = features[0].layer.id;
      canvas.style.cursor = 'move';
      if (id == 'point-1') {
        isCursorOverPoint1 = true;
      } else {
        isCursorOverPoint2 = true;
      }
      map.dragPan.disable();
    } else {
      canvas.style.cursor = '';
      isCursorOverPoint1 = false;
      isCursorOverPoint2 = false;
      map.dragPan.enable();
    }
  });

  map.on('mousedown', mouseDown, true);
});
