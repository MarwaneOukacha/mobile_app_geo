import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FournisseurMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affectation des points de vente"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.0, 0.0), // Coordonnées du centre de la carte
          zoom: 5.0, // Niveau de zoom initial
        ), children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // Service de tuiles OpenStreetMap
          subdomains: ['a', 'b', 'c'],
        ),
          // Ajoutez d'autres marqueurs ici si nécessaire
      ],

          ),
      );
  }
}
