import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FournisseurMap extends StatelessWidget {
  final String email;
  final String emailLivreur;
  FournisseurMap({required this.email,required this.emailLivreur});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affectation des points de vente"),
      ),
      body: WebViewWidget(controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse('http://172.17.224.5:5500/index2.html?frournisseurEmail=$email?livreurEmail=$emailLivreur'))),
      );
  }
}
