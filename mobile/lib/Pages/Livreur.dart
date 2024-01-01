import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LivreurAcceuil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,),
        ),
      ),
      drawer: Drawer(),
      body: Container(),
    );
  }
}