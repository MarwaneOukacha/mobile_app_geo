import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


  FetchLivreurs() async{
    final url =  Uri.parse('http://172.16.11.133:3342/Users/Livreurs');
    try{
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'accept':'application/json'
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        print("Erreur de connexion");
      }
    }catch(e){
      print('Erreur: $e'); // Gère les erreurs potentielles
    }
  }
