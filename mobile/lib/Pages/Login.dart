import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Pages/Livreur.dart';
import 'package:mobile/services/JWTservice.dart';
import 'dart:convert';
import 'package:mobile/services/inputFile.dart';
import 'package:mobile/Pages/FournisseurAcceuil.dart';


class Login extends StatelessWidget {
  final TextEditingController _textFieldControllerEmail = TextEditingController();
  final TextEditingController _textFieldControllerPaswword = TextEditingController();
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
            Navigator.pop(context);
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
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email",controller: _textFieldControllerEmail),
                        inputFile(label: "Password", obscureText: true,controller: _textFieldControllerPaswword)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          String email=_textFieldControllerEmail.text;
                          String password=_textFieldControllerPaswword.text;
                          if (email.isNotEmpty && password.isNotEmpty) {
                            final url =  Uri.parse('http://172.17.224.5:3342/Auth');
                            try{
                              Map<String, String> headers = {
                                'Content-Type': 'application/json',
                                'accept':'application/json'
                              };
                              Map<String, dynamic> postData = {
                                'email': email,
                                'password': password,
                              };

                              // Faites la requête HTTP POST en utilisant les en-têtes et les données spécifiées
                              var response = await http.post(
                                url,
                                headers: headers,
                                body: jsonEncode(postData), // Utilisation des données à envoyer
                              );
                              print(response.statusCode);
                              if (response.statusCode == 200) {
                                String token=response.body;
                                if(JWTservice(token)['Role']=='livreur'){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LivreurAcceuil()));
                                }else{
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>FournisseurAcceuil()));
                                }
                              }else {
                                print("Erreur de connexion");
                              }
                            }catch(e){
                              print('Erreur: $e'); // Gère les erreurs potentielles
                            }
                          }
                          else {
                            print('Veuillez remplir tous les champs');
                          }

    },
                        color: Color(0xff0095ff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/welcom.jpg"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
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
