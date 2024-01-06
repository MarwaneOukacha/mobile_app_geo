import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mobile/Pages/FournisseurMap.dart';
import 'package:mobile/Pages/Login.dart';
import 'package:mobile/Pages/NouveauLivreur.dart';
import 'package:mobile/Pages/NouveaupointVente.dart';
import 'package:mobile/Widgets/menu.dart';

import '../services/FetchUserData.dart';
import '../services/MonSearchDelegate.dart';


class FournisseurAcceuil extends StatefulWidget {
  final String email;
  FournisseurAcceuil({required this.email});
  @override
  _FournisseurAcceuilState createState() => _FournisseurAcceuilState();

}

class _FournisseurAcceuilState extends State<FournisseurAcceuil> {
  List<dynamic> livreursData = []; // Liste pour stocker les données récupérées
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // Appeler la fonction FetchLivreurs au chargement du widget
    fetchData();
  }
  Widget getContent() {
    switch (selectedIndex) {
      case 0: // Cas où "Vos Livreurs" est sélectionné
        return buildListViewForVosLivreurs();
      case 1: // Cas où "Ajouter un livreur" est sélectionné
        return NouveauLivreur(); // Remplacez cette ligne par le widget que vous souhaitez afficher
      default:
        return buildListViewForVosLivreurs(); // Par défaut, afficher la première option
    }
  }
  Future<void> fetchData() async {
    var data = await FetchLivreurs();
    if (data != null) {
      setState(() {
        livreursData = data; // Mettre à jour les données et déclencher le rebuild du widget
      });
    }
  }
  Widget buildListViewForVosLivreurs() {
    return ListView.builder(
      itemCount: livreursData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FournisseurMap(emailLivreur: livreursData[index]['email'], email: widget.email,),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/welcom.jpg"),
                ),
                SizedBox(width: 10), // Espacement entre l'image et le nom
                Text(
                  livreursData[index]['userName'], // Assurez-vous que 'userName' est le champ approprié
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Vous pouvez également ajouter d'autres widgets ici si nécessaire
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Acceuil",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MonSearchDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('En-tête du drawer'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Accueil'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Ajouter un point de vente '),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NouveauPoint(email: widget.email)), // Navigation vers AutreWidget
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Deconnexion '),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()), // Navigation vers AutreWidget
            );
          },
        ),
        // Autres éléments du drawer...
      ],
    ),
    ),
    body:Container(color: Colors.blue,
        child: Column(
          children: <Widget>[
        menu(onItemSelected: (index) {
          setState(() {
          selectedIndex = index; // Mettre à jour l'index sélectionné
        });
        }, selectedIndex: selectedIndex,
      ), // Utilisation du widget menu() Stateful
            Expanded(
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: getContent(),
              ),
            )
          ],
        ),
      )
    );
  }
}

