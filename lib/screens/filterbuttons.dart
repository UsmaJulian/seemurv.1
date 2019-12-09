import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/abierto.dart';
import 'package:seemur_v1/screens/ambientescreen.dart';
import 'package:seemur_v1/screens/bardiscocervscreen.dart';
import 'package:seemur_v1/screens/caracteristicasscreen.dart';
import 'package:seemur_v1/screens/filtros.dart';
import 'package:seemur_v1/screens/formasdepago.dart';
import 'package:seemur_v1/screens/planesscreen.dart';
import 'package:seemur_v1/screens/rangoprecios.dart';
import 'package:seemur_v1/screens/restaurantesscreen.dart';

class FiltrosBotones extends StatefulWidget {
  final BaseAuth auth;

  FiltrosBotones(
      PlanesSelectionScreen planesSelectionScreen,
      AmbienteSelectionScreen ambienteSelectionScreen,
      RestauranteSelectionScreen restauranteSelectionScreen,
      BarDiscoCervSelectionScreen barDiscoCervSelectionScreen,
      CaracteristicaSelectionScreen caracteristicaSelectionScreen,
      RadioListBuilder radioListBuilder,
      RangoPreciosPage rangoPreciosPage,
      CheckListBuilder checkListBuilder,
      {Key key,
      filtros,
      this.auth})
      : super(key: key);
  PlanesSelectionScreen planesSelectionScreen;
  AmbienteSelectionScreen ambienteSelectionScreen;
  RestauranteSelectionScreen restauranteSelectionScreen;
  BarDiscoCervSelectionScreen barDiscoCervSelectionScreen;
  CaracteristicaSelectionScreen caracteristicaSelectionScreen;
  RadioListBuilder radioListBuilder;
  RangoPreciosPage rangoPreciosPage;
  CheckListBuilder checkListBuilder;

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
              onPressed: () async {
                widget.planesSelectionScreen = new PlanesSelectionScreen();
                widget.ambienteSelectionScreen = new AmbienteSelectionScreen();
                widget.restauranteSelectionScreen =
                    new RestauranteSelectionScreen();
                widget.barDiscoCervSelectionScreen =
                    new BarDiscoCervSelectionScreen();
                widget.caracteristicaSelectionScreen =
                    new CaracteristicaSelectionScreen();
                widget.radioListBuilder = new RadioListBuilder();
                widget.rangoPreciosPage = new RangoPreciosPage();
                widget.checkListBuilder = new CheckListBuilder();

                List<String> miPlans = widget.planesSelectionScreen
                    .createState()
                    .getSelectedPlanes();
                List<String> misAmbients = widget.ambienteSelectionScreen
                    .createState()
                    .getSelectedAmbientes();

                var newList = new List.from(miPlans)
                  ..addAll(misAmbients)
                  ..addAll(miPlans);

                FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

                FirebaseUser user = await _firebaseAuth.currentUser();
                print(miPlans);
                await Firestore.instance
                    .collection("filtros")
                    .document(user.uid)
                    .delete();
                await Firestore.instance
                    .collection("filtros")
                    .document(user.uid)
                    .setData({
                  "filtros": newList,
                }).catchError((e) {
                  print(e);
                });

                print("Mis Planes a filtrar: " + miPlans.toString());
              },
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
