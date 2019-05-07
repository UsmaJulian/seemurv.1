import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';
import 'package:seemur_v1/screens/splash_screen_one.dart';

var routes =< String, WidgetBuilder>{
  '/splashtwo':(BuildContext context)=>SplashScreenOne(),
};

void main()=>runApp (MaterialApp(
  title: 'Flutter splash Lading',
  theme: ThemeData(
    primaryColor:Colors.white,
    accentColor: Colors.orange
  ),
  home: SplashScreenOneLoading(),
  routes: routes,
)
); 