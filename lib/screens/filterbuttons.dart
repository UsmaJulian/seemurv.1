import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/filtros.dart';

class FiltrosBotones extends StatefulWidget {
  const FiltrosBotones({Key key, filtros}) : super(key: key);

  @override
  _FiltrosBotonesState createState() => _FiltrosBotonesState();
}

class _FiltrosBotonesState extends State<FiltrosBotones> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 159.0,
            height: 44.0,
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(22), right: Radius.circular(22)),
              gradient: LinearGradient(
                colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 0, // has the effect of extending the shadow
                  offset: Offset(
                    0, // horizontal, move right 10
                    0, // vertical, move down 10
                  ),
                ),
              ],
            ),
            child: FlatButton(
              onPressed: () {},
              child: Text('Filtrar',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            width: 159.0,
            height: 44.0,
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(22), right: Radius.circular(22)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 0, // has the effect of extending the shadow
                  offset: Offset(
                    0, // horizontal, move right 10
                    0, // vertical, move down 10
                  ),
                ),
              ],
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => FiltrosPage(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
              child: Text('Borrar filtros',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
