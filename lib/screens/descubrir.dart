import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';

class Descubrir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new Column(
                //Center the children

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  new Icon(Icons.watch_later, size: 160.0, color: Colors.white),
                  new Text("Segundo Tab",
                      style: new TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: NavigatorBar(),
            ),
          ),
        ],
      ),
    );
  }
}
