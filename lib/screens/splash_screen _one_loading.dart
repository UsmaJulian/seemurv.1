import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:seemur_v1/auth/auth.dart';

class SplashScreenOneLoading extends StatefulWidget {
  SplashScreenOneLoading({this.auth,this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;
  @override
  _SplashScreenOneLoadingState createState() =>
      new _SplashScreenOneLoadingState();
}

class _SplashScreenOneLoadingState extends State<SplashScreenOneLoading> {
  @override
  void initState() {
    // tODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10),
        () => Navigator.pushNamed(context, '/spalshthird'));
  }

  @override
  Widget build(BuildContext context) {
    var assetsImageiso = AssetImage('assets/seemurIsotipo.png');
    var assetsImagelogo = AssetImage('assets/logoSombrero.png');
    var imageiso = Image(
      image: assetsImageiso,
      width: 76.0,
      height: 85.0,
    );
    var imagelogo = Image(
      image: assetsImagelogo,
      width: 213.0,
      height: 43.0,
    );
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [new Color(0xFFF5AF00), new Color(0xFFFFE231)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 110.0, left: 149, right: 150),
                  child: imageiso,
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 53, left: 81, right: 81),
                  child: imagelogo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 29, left: 83, right: 80),
                child: Text(
                  'Descubre, elige y disfruta',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 302, left: 172, right: 173),
                  child: Loading(
                      indicator: BallSpinFadeLoaderIndicator(), size: 30.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14, left: 83, right: 80),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Espera un momento mientras me instalo en tu teléfono',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
