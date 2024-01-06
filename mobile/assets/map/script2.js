document.addEventListener('DOMContentLoaded', () => {
    const myMap = L.map('map').setView([33.9716, -6.8498], 12);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap contributors'
    }).addTo(myMap);
    var id ;
    var idLivreur ;
    var url = window.location.href;
var email = url.split('?')[1].split('=')[1];
    var emaillivreur=url.split('?')[2].split('=')[1]
    fetch(`http://172.17.224.5:3342/Users/fournisseurByEmail/${email}`).then(
        response => {
            if (!response.ok) {
                throw new Error('La requête a échoué');
            }
            return response.json();
        }
    ).then(
        data=>{
            idf=data;
            fetch(`http://172.17.224.5:3342/PointVente/fournisseur/${idf}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('La requête a échoué');
            }
            return response.json();
        })
        .then(data => {
            data.forEach(point => {
                console.log(point);
                L.marker([point.latitude, point.longitude], { icon: myIcon }).addTo(myMap).on('click', function (e) {
                    fetch(`http://172.17.224.5:3342/Users/livreurByEmail/${emaillivreur}`).then(
                        response => {
                            if (!response.ok) {
                                throw new Error('La requête a échoué');
                            }
                            return response.json();
                        }
                    ).then(
                        data => {
                            console.log(data)
                            idLivreur=data;
                            id=point.id;
                            fetch('http://172.17.224.5:3342/PointVente/affecte', {
                                method: 'PUT',
                                headers: {
                                    'Content-Type': 'application/json',
                                },
                                body: JSON.stringify({ id, idLivreur }),
                            })
                                .then(response => {
                                    console.log('Réponse du backend : ', response.status);
                                    location.reload();
                                })
                                .catch(error => {
                                    console.error('Erreur lors de la requête au backend : ', error);
                                });
                        }
                    )
                })

            });
        })
        }
    )
        .catch(error => {
            console.error('Erreur lors de la récupération des données:', error);
        });
});
const myIcon = L.icon({
    iconUrl: 'marker-icon.png', // Spécifiez le chemin de votre icône
    iconSize: [38, 38], // Spécifiez la taille de l'icône
    iconAnchor: [19, 38], // Spécifiez l'ancre de l'icône
    popupAnchor: [0, -38] // Spécifiez l'ancre du popup
});


    
