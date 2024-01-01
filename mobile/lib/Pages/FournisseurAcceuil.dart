import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class FournisseurAcceuil extends StatelessWidget {
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Consulter la liste des livreurs'),
              onTap: () {
                // Action à effectuer lors du tap sur ce ListTile
                // Par exemple, naviguer vers la liste des livreurs
              },
            ),
            ListTile(
              title: Text('Consulter la liste des clients'),
              onTap: () {
                // Action à effectuer lors du tap sur ce ListTile
                // Par exemple, naviguer vers la liste des clients
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Row(
          children: [
            SearchBar(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

              },
            ),
          ],
        ),

      ),

    );
  }
}
