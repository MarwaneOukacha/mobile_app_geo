import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Pages/FournisseurAcceuil.dart';
import 'dart:convert';
import 'package:mobile/services/inputFile.dart';


class NouveauLivreur extends StatelessWidget{
  final TextEditingController _textFieldControllerEmail = TextEditingController();
  final TextEditingController _textFieldControllerUsername = TextEditingController();
  final TextEditingController _textFieldControllerPassword = TextEditingController();
  final TextEditingController _textFieldControllerTele = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>FournisseurAcceuil()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Ajouter un nouveau livreur",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Creer un compte à votre livreur",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Username",controller: _textFieldControllerUsername),
                        inputFile(label: "Telephone",controller: _textFieldControllerTele),
                        inputFile(label: "Email",controller: _textFieldControllerEmail),
                        inputFile(label: "Password", obscureText: true,controller: _textFieldControllerPassword),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 70,
                        onPressed: () async {
                          String Username=_textFieldControllerUsername.text;
                          String Email=_textFieldControllerEmail.text;
                          String Tele=_textFieldControllerTele.text;
                          String password=_textFieldControllerPassword.text;
                          if(Username.isNotEmpty && Email.isNotEmpty && Tele.isNotEmpty && password.isNotEmpty ){
                            final url =  Uri.parse('http://172.17.224.5:3342/Users/registreLivreur');
                            try{
                              Map<String, String> headers = {
                                'Content-Type': 'application/json',
                                'accept':'application/json'
                              };
                              Map<String, dynamic> postData = {
                                'email': Email,
                                'password': password,
                                'numTelephone':Tele,
                                'userName':Username
                              };
                              var response = await http.post(
                                url,
                                headers: headers,
                                body: jsonEncode(postData), // Utilisation des données à envoyer
                              );
                              print(response.statusCode);
                              if (response.statusCode == 200) {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>FournisseurAcceuil()));
                              }else {
                                print("Erreur de connexion");
                              }
                            }catch(e){
                              print('Erreur: $e'); // Gère les erreurs potentielles
                            }
                          }
                        },
                        color: Color(0xff0095ff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Placeholder pour l'élément manquant
          ],
        ),
      ),
    );
  }

}