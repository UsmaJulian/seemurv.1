import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/ciudades.dart';


import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';
//import 'package:seemur_v1/screens/splash_screen_one.dart';

var routes = <String, WidgetBuilder>{
  // '/splashtwo': (BuildContext context) => SplashScreenOne(),
  '/spalshthird': (BuildContext context) => Ciudades(),
};

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
      home:
      SplashScreenOneLoading(),
      routes: routes,
    ));
