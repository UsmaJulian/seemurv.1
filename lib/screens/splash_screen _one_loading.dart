import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:seemur_v1/auth/auth.dart';

class SplashScreenOneLoading extends StatefulWidget {
  SplashScreenOneLoading({this.auth, this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _SplashScreenOneLoadingState createState() =>
      new _SplashScreenOneLoadingState();
}

class _SplashScreenOneLoadingState extends State<SplashScreenOneLoading> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.pushNamed(context, '/spalshthird'));
  }

  @override
  Widget build(BuildContext context) {
    var assetsImageiso = AssetImage('assets/seemurIsotipo.png');
    var assetsImagelogo = AssetImage('assets/logoblanco.png');
    var imageiso = Image(
      image: assetsImageiso,
      height: MediaQuery.of(context).size.height * 0.105,
      width: MediaQuery.of(context).size.width * 0.203,
    );
    var imagelogo = Image(
      image: assetsImagelogo,
      height: MediaQuery.of(context).size.height * 0.053,
      width: MediaQuery.of(context).size.width * 0.568,
    );
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [new Color(0xFFF5AF00), new Color(0xFFFFE231)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 73.33, left: 74.5, right: 75.0),
                      child: imageiso,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 26.5, left: 81.0, right: 81.0, bottom: 3.0),
                          child: imagelogo,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 41.0,
                            right: 31.0,
                          ),
                          child: Text(
                            'Descubre, elige y disfruta',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'HankenGrotesk',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 86, right: 86.5, top: 227),
                      child: Loading(
                          indicator: BallSpinFadeLoaderIndicator(), size: 15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 7.0, left: 41.5, right: 40.0, bottom: 57.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Espera un momento ",
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
        ),
      ),
    );
  }
}
