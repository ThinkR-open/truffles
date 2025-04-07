$(document).ready(function () {
  var map = null;

  Shiny.addCustomMessageHandler("map", function (arg) {
    var locations = arg.data;
    var reens = arg.reens;
    var mean_lat = locations.length
      ? locations.reduce((sum, loc) => sum + Number(loc[2] || 0), 0) /
        locations.length
      : 0;

    var mean_lon = locations.length
      ? locations.reduce((sum, loc) => sum + Number(loc[1] || 0), 0) /
        locations.length
      : 0;

    // Calculer les coordonnées min/max comme avant
    var minLat = Math.min(...locations.map((loc) => Number(loc[2] || 0)));
    var maxLat = Math.max(...locations.map((loc) => Number(loc[2] || 0)));
    var minLon = Math.min(...locations.map((loc) => Number(loc[1] || 0)));
    var maxLon = Math.max(...locations.map((loc) => Number(loc[1] || 0)));
    // Calculer l'étendue géographique
    var latDiff = maxLat - minLat;
    var lonDiff = maxLon - minLon;
    // Calculer la taille de l'écran en pixels
    var screenWidth = window.innerWidth; // Largeur de l'écran en pixels
    // Estimer un niveau de zoom en fonction de l'étendue géographique et de la taille de l'écran
    var zoom = Math.round(
      Math.log2(
        screenWidth / (latDiff + lonDiff * Math.cos((mean_lat * Math.PI) / 180))
      )
    );

    if (map === null) {
      document.getElementById(arg.id).style.height = "580px";
      // Créer la carte uniquement si elle n'existe pas encore
      map = L.map(document.getElementById(arg.id)).setView(
        [mean_lat, mean_lon],
        zoom - 0.7
      );
      L.tileLayer(
        "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
        {
          maxZoom: 19,
          opacity: 0.7,
          attribution:
            '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
        }
      ).addTo(map);
    }

    // Supprimer les anciens marqueurs si la carte existe déjà
    if (map) {
      map.eachLayer(function (layer) {
        if (layer instanceof L.CircleMarker) {
          map.removeLayer(layer);
        }
      });
    }

    for (var i = 0; i < locations.length; i++) {
      marker = new L.circleMarker([locations[i][2], locations[i][1]])
        .unbindPopup()
        .addTo(map)
        .on("click", onClick);

      marker.id = locations[i][0];

      if (reens === 0) {
        if (locations[i][3] === "Normal") {
          marker.setStyle({
            color: "#FF0000",
            fillColor: "#FF0000",
            fillOpacity: 1,
          });
        } else {
          marker.setStyle({
            color: "#FFA500",
            fillColor: "#FFA500",
            fillOpacity: 1,
          });
        }
      } else {
        if (locations[i][7] === "1") {
          marker.setStyle({
            color: "#00AEEF",
            fillColor: "#00AEEF",
            fillOpacity: 1,
          });
        } else {
          marker.setStyle({
            color: "#7f9199",
            fillColor: "#7f9199",
            fillOpacity: 1,
          });
        }
      }
    }

// Fonction pour mettre à jour la taille des marqueurs en fonction du zoom
function updateMarkerSize() {
  var currentZoom = map.getZoom();

  map.eachLayer(function (layer) {
    if (layer instanceof L.CircleMarker) {
      let baseSize = 4; // Taille d'origine
      let zoomFactor = (currentZoom - 10) * 0.5; // Ajustement doux
      let newRadius = baseSize + zoomFactor;

      layer.setStyle({ radius: Math.max(newRadius, baseSize) }); // Évite qu'ils deviennent trop petits
    }
  });
}

// Écouteur d'événement sur le zoom
map.on("zoomend", updateMarkerSize);

    function onClick(e) {
      Shiny.setInputValue("chene_click", this.id);
    }
  });
});
