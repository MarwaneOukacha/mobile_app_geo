import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/Pages/NouveauLivreur.dart';
import 'package:mobile/Widgets/menu.dart';

import '../services/FetchUserData.dart';
import '../services/MonSearchDelegate.dart';


class FournisseurAcceuil extends StatefulWidget {
  @override
  _FournisseurAcceuilState createState() => _FournisseurAcceuilState();
}

class _FournisseurAcceuilState extends State<FournisseurAcceuil> {
  List<dynamic> livreursData = []; // Liste pour stocker les données récupérées

  @override
  void initState() {
    super.initState();
    // Appeler la fonction FetchLivreurs au chargement du widget
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await FetchLivreurs();
    if (data != null) {
      setState(() {
        livreursData = data; // Mettre à jour les données et déclencher le rebuild du widget
      });
    }
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
        // ... Votre code de tiroir (Drawer) ici
      ),
      body:Container(color: Colors.blue,
        child: Column(
          children: <Widget>[
            menu(), // Utilisation du widget menu() Stateful
            Expanded(
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: livreursData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
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
                            );
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

