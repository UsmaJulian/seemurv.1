import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return new Scaffold(
    
  //backgroundColor: Colors.red,
  appBar: AppBar(
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(icon: Icon(Icons.access_time),
      onPressed: (){},
      ),
      IconButton(icon: Icon(Icons.access_alarm),
      onPressed: (){},
      ),

    ],
  ),
  body: new Container(
    child: new Center(
      child: new Column(
        //Center the children
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            
          )
        ],
      ),
    ),
  ),
 );
 }
}