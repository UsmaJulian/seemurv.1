import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

class SplashScreenOneLoading extends StatefulWidget {
  @override
  _SplashScreenOneLoadingState createState() => new _SplashScreenOneLoadingState();
 }
class _SplashScreenOneLoadingState extends State<SplashScreenOneLoading> {
  @override
  void initState() {
    // tODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10),()=>Navigator.pushNamed(context, '/splashtwo'));
  }
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
                 padding:EdgeInsets.only(top: 10.0) ,
                 ),
                 Text('Descubre, elije y disfruta',
                 style:TextStyle(
                   color:Colors.black,
                   fontSize: 30.0, 
                   ),
                   ),
                   Padding(
                 padding:EdgeInsets.only(top: 60.0) ,
                 ),
               Container(
        color: Colors.lightBlue,
        child: Center(
          child: Loading(indicator:BallSpinFadeLoaderIndicator(), size: 100.0),
        ),
      ),     
             ],
           )
       ],
     ),
  
   );
  }
}
