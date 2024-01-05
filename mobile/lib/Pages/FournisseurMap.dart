import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FournisseurMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affectation des points de vente"),
      ),
      body: WebView(
        initialUrl: 'http://172.17.224.5:5500/index.html', // Chemin vers votre fichier map.html
        javascriptMode: JavascriptMode.unrestricted,
      ),
      );
  }
}
