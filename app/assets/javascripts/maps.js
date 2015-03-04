window.onload = function() {

  if (latitude && longitude) {

      // set up control and options
      options = {
        continuousWorld: true,
        worldCopyJump: false,
        minZoom: 14,
        maxZoom: 19,

        // controls
        dragging: false,
        touchZoom: false,
        doubleClickZoom: false,
        scrollWheelZoom: false,
        boxZoom: false,
        keyboard: false,
        tap: false,
        zoomControl: true,
        attributionControl: false
      };

      // set up the map
      var map = new L.Map('map', options);
      // create the tile layer with correct attribution
      var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
      var osm = new L.TileLayer(osmUrl);

      map.addLayer(osm);
      //Add a scale control to the map
      L.control.scale().addTo(map);

      // use the latitude and longitude to find the centre
      var latlng = L.latLng(latitude, longitude);

      markerOptions = {
        clickable: false,
        draggable: false,
        keyboard: false,
        riseOnHover: false
      };

      L.marker(latlng, markerOptions).addTo(map);

      map.setView(latlng, 17);

  } else {
      document.getElementById('map').innerText = 'No map information available';
  }
}
