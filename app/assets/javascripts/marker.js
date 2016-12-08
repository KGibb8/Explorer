
var isDragging1;
var isDragging2;

var isCursorOverPoint1;
var isCursorOverPoint2;

var coordinates = document.getElementById('coordinates');

var canvas = map.getCanvasContainer();

var geojson;

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
  if (isDragging1) {
    geojson.features[0].geometry.coordinates = [coords.lng, coords.lat];
    var cloneData = $.extend(true, {}, geojson);
    cloneData.features.splice(-1);
    map.getSource('point-1').setData(cloneData);
    $('#startLat').val(coords.lat);
    $('#startLng').val(coords.lng);
  } else if (isDragging2) {
    geojson.features[1].geometry.coordinates = [coords.lng, coords.lat];
    var cloneData = $.extend(true, {}, geojson);
    cloneData.features.splice(0, 1);
    map.getSource('point-2').setData(cloneData);
    $('#endLat').val(coords.lat);
    $('#endLng').val(coords.lng);
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

  function getMarkers() {
    return $.get("/expeditions/" + expedition_id + "/markers", {}).done(function (response) {
      geojson = response;

      // Do we want to return two sets of Geojson? One per marker?
      var start_coords = geojson.features[0].geometry.coordinates;
      map.setCenter([start_coords[0], start_coords[1]]);

      map.addSource('point-1', {
        "type": "geojson",
        "data": geojson.features[0]
      });

      map.addSource('point-2', {
        "type": "geojson",
        "data": geojson.features[1]
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
  };

  getMarkers();
});
