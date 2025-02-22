$( document ).ready(function() {

  var map = null;

  Shiny.addCustomMessageHandler('map', function(arg) {

    if (map === null) {
      // Créer la carte uniquement si elle n'existe pas encore
      map = L.map(document.getElementById(arg.id)).setView([47.99889, 1.532564], 50);
      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
      }).addTo(map);
    }


    // Supprimer les anciens marqueurs si la carte existe déjà
    if (map) {
        map.eachLayer(function(layer) {
          if (layer instanceof L.CircleMarker) {
              map.removeLayer(layer);
          }
        });
    }

      var locations = arg.data
      var reens = arg.reens


        for (var i = 0; i < locations.length; i++) {
        marker = new L.circleMarker([locations[i][2], locations[i][1]])
          .bindPopup(locations[i][0])
          .addTo(map).on('click', onClick)
          .setStyle({radius: '6'});

          marker.id = locations[i][0];

if (reens === 0) {

            if (locations[i][3] === "Normal") {
              marker.setStyle({color: '#af4424'})
              } else {
               marker.setStyle({color: '#556b2f'})
                }


} else {
            if (locations[i][7] === "1") {
              marker.setStyle({color: '#184254'})
              } else {
               marker.setStyle({color: '#7f9199'})
                }


      }

}





      function onClick(e) {
        Shiny.setInputValue("chene_click", this.id);
      }

  })
});
