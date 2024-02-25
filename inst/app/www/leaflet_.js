$( document ).ready(function() {
  Shiny.addCustomMessageHandler('map', function(arg) {
      var map = L.map(document.getElementById(arg.id)).setView([47.99889, 1.532564], 50);

      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 19,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

      var locations = arg.data

      for (var i = 0; i < locations.length; i++) {
        marker = new L.circleMarker([locations[i][1], locations[i][2]])
          .bindPopup(locations[i][0])
          .addTo(map).on('click', onClick);

          marker.id = locations[i][0];
          marker.setStyle({fillColor: 'red'})
      }

      function onClick(e) {
        Shiny.setInputValue("chene_click", this.id);
      }

  })
});
