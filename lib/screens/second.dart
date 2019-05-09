import 'package:flutter/material.dart';

class Second extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return new Scaffold(
  appBar: AppBar(
    title: new Text("Segunda Pantalla"),
  ),
  body: new Center(
    child: new RaisedButton(
      onPressed: () {
      Navigator.pop(context);
      },
      child:  new Text("Ir Atras"),
   ),
  ),
 );
 }
}