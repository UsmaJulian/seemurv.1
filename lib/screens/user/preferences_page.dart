import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/ciudades.dart';

class PreferencesPage extends StatelessWidget {
  PreferencesPage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        //onSignOut();
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Ciudades()));
      } catch (e) {
        print(e);
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Container(
              child: new FlatButton(
                  onPressed: _signOut,
                  child: new Text('Cerrar Sesión',
                      style:
                          new TextStyle(fontSize: 17.0, color: Colors.black))),
            )
          ],
        ),
      ),
    );
  }
}
