
const openRouteServiceURL =
  "https://api.openrouteservice.org/v2/directions/driving-car";
const apiKey = "5b3ce3597851110001cf62484de43f7d03a24dcfb1dc8f60528823dc";
let startCoordinates = "-6.8498,33.9716";
let endCoordinates = "-7.5898,33.573";
const headers = new Headers();
headers.append(
  "Accept",
  "application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8"
);
const requestOptions = {
  method: "GET",
  headers,
};

function clearRoute() {
  // Code pour retirer l'itinéraire de la carte.
  myMap.eachLayer(function (layer) {
    if (layer instanceof L.Polyline) {
      myMap.removeLayer(layer);
    }
  });
}

async function displayRoute(routeData) {
  // Code pour afficher l'itinéraire sur la carte.
  clearRoute();
  // Coordonnées de l'itinéraire.
  const coordinates = routeData.features[0].geometry.coordinates;
  // Créez un tableau d'objets de points pour afficher l'itinéraire.
  const routePoints = coordinates.map((coord) => L.latLng(coord[1], coord[0]));

  // Créez une ligne (polyline) pour l'itinéraire.
  const routePolyline = L.polyline(routePoints, { color: "blue" });
  // Ajoutez la ligne à la carte.
  routePolyline.addTo(myMap);
  // Ajustez la vue de la carte pour afficher l'itinéraire.
  myMap.fitBounds(routePolyline.getBounds());
  const distance = routeData.features[0].properties.segments[0].distance;
  const duration = routeData.features[0].properties.segments[0].duration;


}

function selectMode(mode) {
  // Highlight or style the selected mode if needed
  console.log(`Selected mode: ${mode}`);
}

async function fetchData(startCoordinates, endCoordinates, mode = "driving-car") {
  try {
    const response = await fetch(
      `${openRouteServiceURL}?api_key=${apiKey}&start=${startCoordinates}&end=${endCoordinates}&profile=${mode}`,
      requestOptions
    );
    if (response.ok) {
      const data = await response.json();
      displayRoute(data);
      console.log("Itinéraire récupéré avec succès :", data);
    } else {
      clearRoute();
      console.error(
        "Erreur de réponse :",
        response.status,
        response.statusText
      );
    }
  } catch (error) {
    console.error("Erreur lors de la récupération de l'itinéraire :", error);
  }
}
function showRouteFormModal() {
  // Create a modal
  var modal = document.createElement('div');
  modal.classList.add('modal', 'fade');
  modal.id = 'routeModal';
  modal.innerHTML = `
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Suivi des ventes</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <form id="route-form">
            <div class="form-group">
              <label for="start">Quantité vendue:</label>
              <input type="text" class="form-control" id="qtt" >
            </div>
            <button type="submit" class="btn btn-primary">Enregistrer</button>
          </form>
        </div>
      </div>
    </div>
  `;

  // Append the modal to the body
  document.body.appendChild(modal);

  // Show the modal
  $('#routeModal').modal('show');

  // Add event listener for form submission
  modal.querySelector('#route-form').addEventListener('submit', function (event) {
    event.preventDefault();

    // Extract input values
    var quantiteVendue = document.getElementById('qtt').value;

    console.log(quantiteVendue);

    // Send data to the server
    sendDeliveryData(quantiteVendue);

    // Optionally, you can use the information or send it to a URL


    // Optionally, you can remove the modal after submission
    $('#routeModal').modal('hide');
  });
}





const myMap = L.map('mapid').setView([33.9716, -6.8498], 12);

document.addEventListener('DOMContentLoaded', () => {
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '© OpenStreetMap contributors'
  }).addTo(myMap);

  // Le reste de votre code pour la géolocalisation et l'ajout de marqueurs...
});
document.addEventListener('DOMContentLoaded', () => {


  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      var latit = position.coords.latitude;
      var longit = position.coords.longitude;

      // Create a marker for the current position
      currentPositionMarker = L.marker([latit, longit], { icon: myIcon2 }).addTo(myMap);

      // Move the map to have the location in its center
      myMap.panTo(new L.LatLng(latit, longit));

      // Optional: Add a popup to the marker with the coordinates
      currentPositionMarker.bindPopup(`<h6>Votre position actuelle</h6><p>Latitude: ${latit}<br>Longitude: ${longit}</p>`);
    });
  }
  const url = window.location.href;
  const email = url.split('=')[1];
fetch(`http://172.17.224.5:3342/Users/livreurByEmail/${email}`).then(
  response => {
    if (!response.ok) {
      throw new Error('La requête a échoué');
    }
    return response.json();
  }
).then(
  data=>{
    fetch(`http://172.17.224.5:3342/PointVente/${data}`).then(
    response => {
      if (!response.ok) {
        throw new Error('La requête a échoué');
      }
      return response.json();
    }
  ).then(data => {
    data.forEach(element => {
      var rabatMarker = L.marker([element.latitude, element.longitude], { icon: myIcon }).addTo(myMap);
      rabatMarker.on('click', function () {
        // Check if current position marker exists
        if (currentPositionMarker) {
          // Get the coordinates of the Rabat marker
          var rabatCoords = rabatMarker.getLatLng();

          // Fetch the route between current position and Rabat
          fetchData(`${currentPositionMarker.getLatLng().lng},${currentPositionMarker.getLatLng().lat}`, `${rabatCoords.lng},${rabatCoords.lat}`);
          showRouteFormModal("Your Starting Point");
        }
      });
    });


  }
  )
  }
).catch(error => {
    console.error('Erreur lors de la récupération des données:', error);
  });
})
const myIcon = L.icon({
  iconUrl: 'marker-icon.png', // Spécifiez le chemin de votre icône
  iconSize: [38, 38], // Spécifiez la taille de l'icône
  iconAnchor: [19, 38], // Spécifiez l'ancre de l'icône
  popupAnchor: [0, -38] // Spécifiez l'ancre du popup
});

const myIcon2 = L.icon({
  iconUrl: 'marker-icon-2x.png', // Spécifiez le chemin de votre icône
  iconSize: [40, 40], // Spécifiez la taille de l'icône
  iconAnchor: [19, 38], // Spécifiez l'ancre de l'icône
  popupAnchor: [0, -38] // Spécifiez l'ancre du popup
});

