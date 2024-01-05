let latitude=0;
let longitude=0;
document.addEventListener('DOMContentLoaded', () => {
    const myMap = L.map('mapp').setView([33.9716, -6.8498], 12); 
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap contributors'
    }).addTo(myMap);
    myMap.on('click', function(e) {
        latitude = e.latlng.lat;
        longitude = e.latlng.lng;
        console.log(`Latitude: ${latitude}, Longitude: ${longitude}`);
        // Utilisez les valeurs de latitude et longitude comme vous le souhaitez, par exemple, pour placer un marqueur
        const marker = L.marker([latitude, longitude],{ icon: myIcon }).addTo(myMap);
    });
});


const myIcon = L.icon({
    iconUrl: 'marker-icon.png', // Spécifiez le chemin de votre icône
    iconSize: [38, 38], // Spécifiez la taille de l'icône
    iconAnchor: [19, 38], // Spécifiez l'ancre de l'icône
    popupAnchor: [0, -38] // Spécifiez l'ancre du popup
});

function ajouterPointerEvent(){
    email="mehdi@gmail.com";
    capacite_stockage=document.getElementById('capacite_stockage').value;
    dateVisite=document.getElementById('dateVisite').value;
    contact=document.getElementById('contact').value;
    fetch(`http://localhost:3342/PointVente/${email}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ longitude, latitude,capacite_stockage, contact,dateVisite}),
        }).then( 
            response => {
                console.log('Réponse du backend : ', response);
            }
        ).catch()
}