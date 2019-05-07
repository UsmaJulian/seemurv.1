import 'package:flutter/material.dart';

class SplashScreenOne extends StatefulWidget {
  @override
  _SplashScreenOneState createState() => new _SplashScreenOneState();
 }
class _SplashScreenOneState extends State<SplashScreenOne> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       fit: StackFit.expand,
       children: <Widget>[
         Container(
           decoration:BoxDecoration(
             color: new Color(0xffffffff),
             gradient: LinearGradient(
               colors: [new Color(0xffffffff),new Color(0xffffffff)], 
               begin: Alignment.centerRight,
               end: Alignment.centerLeft,
             )
           ),
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 75.0,
                 child: Icon(
                   Icons.beach_access,
                   color: Colors.deepOrange,
                   size:50.0,
                 ),
               ),
               Padding(
                 padding:EdgeInsets.only(top: 60.0) ,
                 ),
                 Text('Descubre,elije y disfruta',
                 style:TextStyle(
                   color:Colors.black,
                   fontSize: 30.0, 
                   ),
                   ),
                   Padding(
                 padding:EdgeInsets.only(top: 80.0,) ,
                 ),
                  Text('Por favor espera unos segundos mientras Seemur se instala en tu teléfono',
                 style:TextStyle(
                   color:Colors.black,
                   fontSize: 24.0, 
                   ),
                   ),
                 
             ],
           )
       ],
     ),
  
   );
  }
}