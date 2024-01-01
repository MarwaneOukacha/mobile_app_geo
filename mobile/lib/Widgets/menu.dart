import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _menu();
}

class _menu extends State<menu>{
  int selectedIndex=0;
  final List<String> menu=["Vos Livreurs","Ajouter un livreur"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 90.0,
      color: Colors.blue,
      child: ListView.builder(scrollDirection: Axis.horizontal,
          itemCount:menu.length,
          itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            setState(() {
              selectedIndex=index;
            });
          },
          child: Padding(padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0
          ),
            child: Text(
              menu[index],
              style: TextStyle(color: index==selectedIndex?Colors.white:Colors.white60,fontSize: 24.0,fontWeight: FontWeight.bold,letterSpacing: 1.2),
            ),
          ),
        );

          }),
    );
  }

}
