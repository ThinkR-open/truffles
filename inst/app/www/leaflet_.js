$( document ).ready(function() {
  Shiny.addCustomMessageHandler('map', function(arg) {


      var map = L.map(document.getElementById(arg.id)).setView([47.99889, 1.532564], 50);

      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 19,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

      var locations = arg.data

      for (var i = 0; i < locations.length; i++) {
        marker = new L.circleMarker([locations[i][2], locations[i][1]])
          .bindPopup(locations[i][0])
          .addTo(map).on('click', onClick);

          marker.id = locations[i][0];

            if (locations[i][3] === "Normal") {
              marker.setStyle({color: '#af4424'})
              } else {
               marker.setStyle({color: '#556b2f'})
                }


      }

      function onClick(e) {
        Shiny.setInputValue("chene_click", this.id);
      }

  })
});
